class AwardObject

  include Foundry
  include DataFactory
  include Navigation
  include DateFactory
  include StringFactory

  attr_accessor :description, :transaction_type, :id, :award_status,
                :award_title, :lead_unit, :activity_type, :award_type, :sponsor_id,
                :project_start_date, :project_end_date, :obligation_start_date,
                :obligation_end_date, :anticipated_amount, :obligated_amount, :document_id,
                :creation_date, :transactions, :key_personnel, :cost_sharing, :fa_rates,
                :funding_proposals

                #TODO: Add Benefits rates...

  def initialize(browser, opts={})
    @browser = browser

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
      anticipated_amount:    '1000000',
      obligated_amount:      '1000000',
      funding_proposals:     [], # Contents MUST look like: {ip_number: '00001', merge_type: 'No Change'}, ...
      subawards:             [], # Contents MUST look like: {org_name: 'Org Name', amount: '999.99'}, ...
      transactions:          collection('Transaction'),
      key_personnel:         collection('AwardKeyPersonnel'),
      cost_sharing:          collection('AwardCostSharing'),
      fa_rates:              collection('AwardFARates')
    }

    set_options(defaults.merge(opts))
  end

  def create
    @creation_date = right_now[:date_w_slashes]
    visit(CentralAdmin).create_award
    on Award do |create|
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
    end

  end

  def add_funding_proposal(ip_number, merge_type)
    navigate
    on Award do |page|
      page.expand_all
      page.institutional_proposal_number.fit ip_number
      page.proposal_merge_type.pick merge_type
      page.save
    end
    @funding_proposals << {ip_number: ip_number, merge_type: merge_type}
  end

  def add_subaward(name, amount)
    navigate
    on Award do |page|
      page.expand_all
      page.add_organization_name.fit name
      page.add_subaward_amount.fit amount
      page.save
    end
    @subawards << {org_name: name, amount: amount}
  end

  def add_transaction opts={}
    defaults={award_id: @id}
    @transactions.add defaults.merge(opts)
  end

  def add_pi opts={}
    navigate
    on(Award).contacts
    @key_personnel.add opts
  end

  def add_key_person opts={}
    defaults={project_role: 'Key Person', key_person_role: random_alphanums}
    add_pi defaults.merge(opts)
  end

  def view(tab)
    navigate
    unless on(Award).send(StringFactory.damballa("#{tab}_button")).parent.class_name=~/tabcurrent$/
      on(Award).send(StringFactory.damballa(tab.to_s))
    end
  end

  # TODO: Move this to a shared module. The same method is
  # used in the Proposal Development Object
  # This method simply sets all the credit splits to
  # equal values based on how many persons and units
  # are attached to the Proposal. If more complicated
  # credit splits are needed, these will have to be
  # coded in the step def, accessing the key person
  # objects directly.
  def set_valid_credit_splits
    # calculate a "person" split value that will work
    # based on the number of people attached...
    split = (100.0/@key_personnel.with_units.size).round(2)

    # Now make a hash to use for editing the person's splits...
    splits = {responsibility: split, financial: split, recognition: split, space: split}

    # Now we update the KeyPersonObjects' instance variables
    # for their own splits as well as for their units
    @key_personnel.with_units.each do |person|
      person.edit splits
      units_split = (100.0/person.units.size).round(2)
      # Make a temp container for the units we're updating...
      units = []
      person.units.each { |unit| units << {:number=>unit[:number]} }
      # Iterate through the units, updating their credit splits with the
      # valid split amount...
      units.each do |unit|
        [:responsibility, :financial, :recognition, :space].each { |item| unit[item]=units_split }
      end
      person.update_unit_credit_splits units
    end
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

  # ==========
  private
  # ==========

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