class AwardObject < DataObject

  include Navigation
  include DateFactory
  include StringFactory
  include DocumentUtilities

  attr_accessor :description, :transaction_type, :id, :award_status,
                :award_title, :lead_unit, :activity_type, :award_type, :sponsor_id, :sponsor_type_code,
                :nsf_science_code, :account_id, :account_type, :prime_sponsor, :cfda_number,
                :project_start_date, :project_end_date, :obligation_start_date,
                :obligation_end_date, :anticipated_amount, :obligated_amount, :document_id,
                :document_status,
                :creation_date, :key_personnel, :cost_sharing, :fa_rates,
                :funding_proposals, :subawards, #TODO: Add Benefits rates and preaward auths...
                :time_and_money,
                :budget_versions, :sponsor_contacts, :payment_and_invoice, :terms, :reports,
                :custom_data,
                :parent, :children

  def initialize(browser, opts={})
    @browser = browser
    amount = random_dollar_value(1000000)

    defaults = {
      description:           random_alphanums,
      transaction_type:      '::random::',
      award_status:          'Active', # Needs to be this way because we don't want it to pick a status of 'Closed'
      award_title:           random_alphanums,
      activity_type:         '::random::',
      award_type:            '::random::',
      project_start_date:    right_now[:date_w_slashes],
      project_end_date:      in_a_year[:date_w_slashes],
      sponsor_type_code:     '::random::',
      sponsor_id:            '::random::',
      lead_unit:             '::random::',
      obligation_start_date: right_now[:date_w_slashes],
      obligation_end_date:   in_a_year[:date_w_slashes],
      account_id:            random_alphanums(7),
      account_type:          '::random::',
      prime_sponsor:         '::random::',
      cfda_number:           "#{"%02d"%rand(99)}.#{"%03d"%rand(999)}",
      anticipated_amount:    amount,
      obligated_amount:      amount,
      funding_proposals:     [], # Contents MUST look like: {ip_number: '00001', merge_type: 'No Change'}, ...
      subawards:             [], # Contents MUST look like: {org_name: 'Org Name', amount: '999.99'}, ...
      sponsor_contacts:      [], # Contents MUST look like: {non_employee_id: '333', project_role: 'Close-out Contact'}, ...
      key_personnel:         collection('AwardKeyPersonnel'),
      cost_sharing:          collection('AwardCostSharing'),
      fa_rates:              collection('AwardFARates'),
      children:              [], # Contains the ids of any child Awards.
      #budget_versions:       collection('BudgetVersions'), # This is not yet verified to work with Awards.

    }
    @lookup_class=AwardLookup
    set_options(defaults.merge(opts))
  end

  def create
    @creation_date = right_now[:date_w_slashes]
    visit(CentralAdmin).create_award
    on Award do |create|
      @doc_header=create.doc_title
      create.expand_all
      fill_out create, :description, :transaction_type, :award_status, :award_title,
               :activity_type, :award_type, :obligated_amount, :anticipated_amount,
               :project_start_date, :project_end_date, :obligation_start_date,
               :obligation_end_date, :nsf_science_code, :account_id, :account_type,
               :cfda_number
      set_sponsor_id
      set_prime_sponsor
      set_lead_unit
      @funding_proposals.each do |prop|
        create.institutional_proposal_number.fit prop[:ip_number]
        create.proposal_merge_type.pick prop[:merge_type]
        create.add_proposal
      end
      @subawards.each do |sa|
        create.add_organization_name.fit sa[:org_name]
        create.add_subaward_amount.fit sa[:amount]
        create.add_subaward
      end
      create.save
      @document_id = create.header_document_id
      @id = create.header_award_id.strip
      @search_key = { award_id: @id }
      @document_status = create.header_status
    end
  end

  def edit opts={}
    #TODO
    set_options(opts)
  end

  def add_funding_proposal(ip_number, merge_type)
    view :award
    on Award do |page|
      page.expand_all
      page.institutional_proposal_number.fit ip_number
      page.proposal_merge_type.pick merge_type
      page.add_proposal
      page.save
    end
    @funding_proposals << {ip_number: ip_number, merge_type: merge_type}
  end

  def remove_funding_proposal(ip_number)
    view :award
    on Award do |page|
      page.expand_all
      page.delete_funding_proposal ip_number
      page.save
    end
    @funding_proposals.reject! { |item| item[:ip_number]==ip_number }
  end

  def add_subaward(name='random', amount=nil)
    amount ||= random_dollar_value(10000000)
    view :award
    on Award do |page|
      page.expand_all
      if name=='random'
        page.search_organization
        on OrganizationLookup do |search|
          search.search
          search.return_random
        end
        name=page.add_organization_name.value
      else
        page.add_organization_name.fit name
      end
      page.add_subaward_amount.fit amount
      page.add_subaward
      page.save
    end
    @subawards << {org_name: name, amount: amount}
  end

  def add_pi opts={}
    view :contacts
    @key_personnel.add opts
  end
  alias_method :add_principal_investigator, :add_pi

  def add_key_person opts={}
    defaults={project_role: 'Key Person', key_person_role: random_alphanums}
    add_pi defaults.merge(opts)
  end

  def add_sponsor_contact opts={}
    s_c = opts.empty? ? {non_employee_id: rand(4000..4103).to_s, project_role: '::random::'} : opts
    view :contacts
    on AwardContacts do |page|
      page.expand_all
      while page.org_name==' '
        page.sponsor_non_employee_id.set s_c[:non_employee_id]
        page.sponsor_project_role.pick! s_c[:project_role]
        page.unit_employee_user_name.focus
        sleep 0.5 # FIXME!
      end
      page.add_sponsor_contact
      page.save
    end
    @sponsor_contacts << s_c
  end

  def add_payment_and_invoice opts={}
    raise "You already created a Payment & Invoice in your scenario.\nYou want to interact with that item directly, now." unless @payment_and_invoice.nil?
    view :payment_reports__terms
    @payment_and_invoice = make PaymentInvoiceObject, opts
    @payment_and_invoice.create
  end

  def add_reports opts={}
    raise "You already created a Reports item in your scenario.\nYou want to interact with it directly, now." unless @reports.nil?
    view :payment_reports__terms
    @reports = make AwardReportsObject, opts
    @reports.create
  end

  def add_terms opts={}
    raise "You already created terms in your scenario.\nYou want to interact with that object directly, now." unless @terms.nil?
    view :payment_reports__terms
    @terms = make AwardTermsObject, opts
    @terms.create
  end

  def add_custom_data opts={}
    view :contacts
    defaults = {
        document_id: @document_id,
        doc_type: @doc_type
    }
    @custom_data = make CustomDataObject, defaults.merge(opts)
    @custom_data.create
  end

  def initialize_time_and_money
    open_document
    on(Award).time_and_money
    # Set up to only create the instance variable if it doesn't exist, yet
    @time_and_money ||= make TimeAndMoneyObject, id: on(TimeAndMoney).header_document_id
  end

  def view(tab)
    open_document
    unless on(Award).send(StringFactory.damballa("#{tab}_button")).parent.class_name=~/tabcurrent$/
      on(Award).send(StringFactory.damballa(tab.to_s))
    end
  end

  def submit
    view :award_actions
    on AwardActions do |page|
      page.submit

      # TODO: Code for intelligently handling the appearance of this
      confirmation

      page.t_m_button.wait_until_present

      @document_status=page.header_status
    end
  end

  def copy(type='new', parent=nil, descendents=:clear)
    view :award_actions
    on AwardActions do |copy|
      copy.close_parents
      copy.expand_all
      copy.expand_tree
      sleep 3 # FIXME!
      copy.show_award_details_panel(@id) unless copy.award_div(@id).visible?
      copy.copy_descendents(@id).send(descendents) if copy.copy_descendents(@id).enabled?
      copy.send("copy_as_#{type}", @id).set
      copy.child_of_target_award(@id).pick! parent
      copy.copy_award @id
    end

    # Make the new data object...
    award = data_object_copy

    # Clean up the data to match...
    award.subawards = nil
    award.transaction_type = 'New'
    award.anticipated_amount = '0.00'
    award.obligated_amount = '0.00'

    on Award do |page|
      award.id = page.header_award_id
      award.document_id = page.header_document_id
      award.custom_data.document_id = page.header_document_id
    end

    # Modify the new data object according to the
    # type of "copy" being done...
    case
      when type=='new' && descendents==:clear
        # Need to modify values for fields/subobjects
        # that don't copy or won't be the same...

        on Award do |page|
          # TODO: Determine if this is all we want, here...
          award.description = random_alphanums
          page.description.set award.description

          page.project_end_date.set @project_end_date

          page.save
          award.document_status=page.header_status
        end

        award.time_and_money=nil

        award.project_start_date = ''
        award.project_end_date = ''
        award.obligation_start_date = ''
        award.obligation_end_date = ''

      when type=='child_of' && descendents==:clear
        @children << award.id
        on Award do |page|
          # TODO: Determine if this is all we want, here...
          award.description = random_alphanums
          page.description.set award.description
          page.save
          award.document_status=page.header_status
        end

        award.time_and_money = @time_and_money
        award.parent = parent

      when type=='new' && descendents==:set

        on Award do |page|
          award.document_status=page.header_status
          page.award_actions
        end
        on AwardActions do |page|
          page.expand_all
          sleep 1 # FIXME!
          page.expand_tree
          sleep 2 # FIXME!
          award.children = page.descendants(award.id)
        end

        award.time_and_money=nil
        award.description = 'Copied Hierarchy' # FIXME!

      when type=='child_of' && descendents==:set
        @children << award.id
        award.description = 'Copied Hierarchy' # FIXME!
        award.time_and_money = @time_and_money
        award.parent = parent

    end

    award
  end

  # ========
  private
  # ========

  def set_prime_sponsor
    if @prime_sponsor=='::random::'
      on(page_class).lookup_prime_sponsor
      on SponsorLookup do |look|
        fill_out look, :sponsor_type_code
        look.search
        look.page_links[rand(look.page_links.length)].click if look.page_links.size > 0
        look.return_random
      end
      @prime_sponsor=on(page_class).prime_sponsor.value
    else
      on(page_class).prime_sponsor.fit @prime_sponsor
    end
  end

  def set_lead_unit
    lu_edit = on(Award).lead_unit_id.present?
    randomize = @lead_unit=='::random::'
    if lu_edit && randomize
      on(Award).lookup_lead_unit
      on UnitLookup do |lk|
        lk.search
        lk.return_random
      end
    elsif lu_edit && !randomize
      on(Award).lead_unit_id.fit @lead_unit
    else
      @lead_unit=on(Award).lead_unit_ro
    end
  end

  def open_document
    navigate unless on_award?
    on(TimeAndMoney).return_to_award if on_tm?
  end

  def navigate
    visit @lookup_class do |page|
      page.award_id.set @id
      page.search
      page.medusa
    end
    # Must update the document id, now:
    @document_id=on(Award).header_document_id
  end

  def on_award?
    if on(Award).headerinfo_table.exist?
      on(Award).header_award_id==@id
    else
      false
    end
  end

  def on_tm?
    !(on(Award).t_m_button.exist?)
  end

  def page_class
    Award
  end

end