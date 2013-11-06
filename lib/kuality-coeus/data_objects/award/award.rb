class AwardObject < DataObject

  include Navigation
  include DateFactory
  include StringFactory
  include DocumentUtilities

  attr_accessor :description, :transaction_type, :id, :award_status,
                :award_title, :lead_unit, :activity_type, :award_type, :sponsor_id,
                :project_start_date, :project_end_date, :obligation_start_date,
                :obligation_end_date, :anticipated_amount, :obligated_amount, :document_id,
                :document_status,
                :creation_date, :key_personnel, :cost_sharing, :fa_rates,
                :funding_proposals, #TODO: Add Benefits rates and preaward auths...
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
      sponsor_id:            '::random::',
      lead_unit:             '::random::',
      obligation_start_date: right_now[:date_w_slashes],
      obligation_end_date:   in_a_year[:date_w_slashes],
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
    set_options(defaults.merge(opts))
  end

  def create
    @creation_date = right_now[:date_w_slashes]
    visit(CentralAdmin).create_award
    on Award do |create|
      @doc_type=create.doc_title
      @document_id=create.header_award_id
      create.expand_all
      fill_out create, :description, :transaction_type, :award_status, :award_title,
               :activity_type, :award_type, :obligated_amount, :anticipated_amount,
               :project_start_date, :project_end_date, :obligation_start_date,
               :obligation_end_date
      set_sponsor_id
      set_lead_unit
      @funding_proposals.each do |prop|
        create.institutional_proposal_number.fit prop[:ip_number]
        create.proposal_merge_type.pick prop[:merge_type]
      end
      @subawards.each do |sa|
        create.add_organization_name.fit sa[:org_name]
        create.add_subaward_amount.fit sa[:amount]
        create.add_subaward
      end
      create.save
      @document_id = create.header_document_id
      @id = create.header_award_id
      @document_status = create.header_status
    end
  end

  def edit opts={}

    set_options(opts)
  end

  def add_funding_proposal(ip_number, merge_type)
    view :award
    on Award do |page|
      page.expand_all
      page.institutional_proposal_number.fit ip_number
      page.proposal_merge_type.pick merge_type
      page.save
    end
    @funding_proposals << {ip_number: ip_number, merge_type: merge_type}
  end

  def add_subaward(name, amount)
    view :award
    on Award do |page|
      page.expand_all
      page.add_organization_name.fit name
      page.add_subaward_amount.fit amount
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
        sleep 0.5
      end
      page.add_sponsor_contact
      page.save
    end
    @sponsor_contacts << s_c
  end

  def add_payment_and_invoice opts={}
    raise "You already created a Payment & Invoice in your scenario.\nYou want to interact with that item directly, now." unless @payment_and_invoice.nil?
    view :payment_reports__terms
    @payment_and_invoice = make PaymentInvoice, opts
    @payment_and_invoice.create
  end

  def add_reports opts={}
    raise "You already created a Reports item in your scenario.\nYou want to interact with it directly, now." unless @reports.nil?
    view :payment_reports__terms
    @reports = make AwardReports, opts
    @reports.create
  end

  def add_terms opts={}
    raise "You already created terms in your scenario.\nYou want to interact with that object directly, now." unless @terms.nil?
    view :payment_reports__terms
    @terms = make AwardTerms, opts
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
    navigate
    on(Award).time_and_money
    # Set up to only create the instance variable if it doesn't exist, yet
    @time_and_money ||= make TimeAndMoneyObject, id: on(TimeAndMoney).header_document_id
  end

  def view(tab)
    navigate
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

      @document_status==page.header_status
    end
  end

  def copy(type='new', descendents=:clear, parent=nil)
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
    award = data_object_copy

    # Need to do this because a deep copy is
    # not appropriate here...
    award.time_and_money = @time_and_money

    case
      when type=='new' && descendents==:clear
        # Need to modify values for fields that don't copy or won't be the same...
        on Award do |page|
          award.id = page.header_award_id
          award.document_id = page.header_document_id
          award.description = page.description.value
          award.project_start_date = page.project_start_date.value
          award.project_end_date = page.project_end_date.value
          award.obligation_start_date = page.obligation_start_date.value
          award.obligation_end_date = page.obligation_end_date.value
          award.anticipated_amount = page.anticipated_amount.value
          award.obligated_amount = page.obligated_amount.value
        end
      when type=='child_of' && descendents==:clear

      when type=='new' && descendents==:set

      when type=='child_of' && descendents==:set

    end
    award
  end

  # ========
  private
  # ========

  # TODO: Move this to a shared module. The same method is
  # used in the Proposal Development Object
  def set_sponsor_id
    if @sponsor_id=='::random::'
      on(Award).lookup_sponsor
      on SponsorLookup do |look|
        look.sponsor_type_code.pick! '::random::'
        look.search
        look.page_links[rand(look.page_links.length)].click if look.page_links.size > 0
        look.return_random
      end
      @sponsor_id=on(Award).sponsor_id.value
    else
      on(Award).sponsor_id.fit @sponsor_id
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

  def navigate
    doc_search unless on_award?
    on(TimeAndMoney).return_to_award if on_tm?
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

end