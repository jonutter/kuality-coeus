class ProposalDevelopmentObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation
  
  attr_accessor :proposal_type, :lead_unit, :activity_type, :project_title,
                :sponsor_code, :sponsor_type_code, :project_start_date, :project_end_date, :document_id,
                :status, :initiator, :created, :sponsor_deadline_date, :key_personnel,
                :special_review, :budget_versions, :permissions, :s2s_questionnaire,
                :proposal_questions, :compliance_questions, :kuali_u_questions, :custom_data#, :description

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      #description:           random_alphanums,
      proposal_type:         'New',
      lead_unit:             '::random::',
      activity_type:         '::random::',
      project_title:         random_alphanums,
      sponsor_code:          '::random::',
      sponsor_type_code:     '::random::',
      project_start_date:    next_week[:date_w_slashes],
      project_end_date:      next_year[:date_w_slashes],
      sponsor_deadline_date: next_week[:date_w_slashes],
      key_personnel:         KeyPersonnelCollection.new,
      special_review:        SpecialReviewCollection.new,
      budget_versions:       BudgetVersionsCollection.new
    }

    set_options(defaults.merge(opts))
  end
    
  def create
    visit(Researcher).create_proposal
    on Proposal do |doc|
      @document_id=doc.document_id
      @status=doc.status
      @initiator=doc.initiator
      @created=doc.created
      doc.expand_all
      fill_out doc, :proposal_type, :activity_type,
                    :project_title, :project_start_date, :project_end_date,
                    :sponsor_deadline_date#, :description
      set_sponsor_code
      set_lead_unit
      doc.save
      @permissions = make PermissionsObject, document_id: @document_id, aggregators: [@initiator]
    end
  end

  def add_key_person opts={}
    merge_settings(opts)
    kpo = make KeyPersonObject, opts
    kpo.create
    @key_personnel << kpo
  end
  # This alias is recommended only for when
  # using this method with no options.
  alias_method :add_principal_investigator, :add_key_person


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

  def add_special_review opts={}
    merge_settings(opts)
    sro = make SpecialReviewObject, opts
    sro.create
    @special_review << sro
  end

  def add_budget_versions opts={}
    merge_settings(opts)
    bvo = make BudgetVersionsObject, opts
    bvo.create
    @budget_versions << bvo
  end

  def add_custom_data opts={}
    merge_settings(opts)
    @custom_data = make CustomDataObject, opts
    @custom_data.create
  end

  def delete
    open_document
    on(Proposal).proposal_actions
    on(ProposalActions).delete_proposal
    on(ConfirmationPage).yes
    # Have to update the data object's status value
    # in a valid way (getting it from the system)
    visit DocumentSearch do |search|
      search.document_id.set @document_id
      search.search
      @status=search.doc_status @document_id
    end
  end

  def recall
    open_document
    on(Proposal).recall
  end

  def close
    open_document
    on(Proposal).close
  end

  def view
    open_document
    on Proposal do |page|
      page.proposal unless page.description.exists? || @status=='CANCELED'
    end
  end

  def submit
    open_document
    on(Proposal).proposal_actions
    on(ProposalActions).submit
  end

  # =======
  private
  # =======

  def merge_settings(opts)
    defaults = {
        document_id: @document_id
    }
    opts.merge!(defaults)
  end

  def set_sponsor_code
    if @sponsor_code=='::random::'
      on(Proposal).find_sponsor_code
      on SponsorLookup do |look|
        look.sponsor_type_code.pick! @sponsor_type_code
        look.search
        look.page_links[rand(look.page_links.length)].click if look.page_links.size > 0
        look.return_random
      end
    else
      on(Proposal).sponsor_code.fit @sponsor_code
    end
  end

  def set_lead_unit
    on(Proposal)do |prop|
      if prop.lead_unit.present?
        prop.lead_unit.pick! @lead_unit
      else
        @lead_unit=prop.lead_unit_ro
      end
    end
  end

end