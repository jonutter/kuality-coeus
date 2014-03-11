class InstitutionalProposalObject < DataObject

  include StringFactory
  include DateFactory
  include Navigation
  include DocumentUtilities
  include Observable

  attr_reader :document_id, :proposal_number, :dev_proposal_number, :project_title,
              :doc_status, :sponsor_id, :activity_type, :proposal_type, :proposal_status,
              :project_personnel, :custom_data, :special_review, :cost_sharing,
              :award_id, :initiator, :proposal_log, :unrecovered_fa,
              :key_personnel, :nsf_science_code, :prime_sponsor_id, :account_id, :cfda_number

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        proposal_status:   'Pending',
        activity_type:     '::random::',
        sponsor_id:        '::random::',
        project_personnel: collection('ProjectPersonnel'),
        special_review:    collection('SpecialReview'),
        cost_sharing:      collection('IPCostSharing'),
        unrecovered_fa:    collection('IPUnrecoveredFA'),
        description:       random_alphanums
    }

    # Came from nothing
    if !opts[:proposal_log] && !opts[:proposal_number]
      prop_log = make ProposalLogObject, sponsor_id: defaults[:sponsor_id]
      prop_log.create
      defaults[:proposal_type]=prop_log.proposal_type
      defaults[:proposal_number]=prop_log.number
      defaults[:project_title]=prop_log.title
      defaults[:proposal_log]=prop_log

    # Came from Proposal Log
    elsif opts[:proposal_log] && !opts[:proposal_number]
      defaults[:proposal_type]=opts[:proposal_log].proposal_type
      defaults[:project_title]=opts[:proposal_log].title
      defaults[:sponsor_id]=opts[:proposal_log].sponsor_id
      defaults[:proposal_number]=opts[:proposal_log].number

    # Otherwise it came from Proposal Development so we need do nothing...
    end

    set_options(defaults.merge(opts))
    @key_personnel = @project_personnel
    @lookup_class=InstitutionalProposalLookup
    # Unfortunately this has to be hard-coded because
    # most of the time this object's #make will not also
    # run the #create
    @doc_header='KC Institutional Proposal '
    @search_key={ institutional_proposal_number: @proposal_number }
  end

  # This method is appropriate only in the context of creating an
  # Institutional Proposal from a Proposal Log.
  def create
    visit(CentralAdmin).create_institutional_proposal
    on ProposalLogLookup do |look|
      look.proposal_number.set @proposal_number
      look.search
      look.select_item @proposal_number
    end
    on InstitutionalProposal do |create|
      create.expand_all
      @document_id=create.document_id
      @doc_header=create.doc_title
      @proposal_number=create.institutional_proposal_number
      fill_out create, :proposal_type, :award_id, :activity_type, :project_title, :description
      set_sponsor_code
      create.save
    end
    if @proposal_log
      pi = make ProjectPersonnelObject, principal_name: @proposal_log.principal_investigator,
                full_name: @proposal_log.pi_full_name,
                document_id: @document_id,
                lookup_class: @lookup_class,
                search_key: @search_key,
                doc_header: @doc_header
      add_observer(pi)
      @project_personnel << pi
      view :contacts
      @project_personnel.principal_investigator.set_up_units
    end
  end

  def edit opts={}
    view :institutional_proposal
    on InstitutionalProposal do |edit|
      edit.edit if edit.edit_button.present?
      edit.expand_all
      edit_fields opts, edit, :proposal_type, :award_id, :activity_type, :project_title, :description
      edit.save
      if @document_id != edit.document_id
        @document_id=edit.document_id
        changed
        notify_observers(@document_id)
      end
    end
  end

  def view(tab)
    open_document
    on(InstitutionalProposal).send(StringFactory.damballa(tab.to_s))
  end

  def add_custom_data opts={}
    view :custom_data
    defaults = {
        document_id: @document_id,
        doc_header: @doc_header,
        lookup_class: @lookup_class,
        search_key: @search_key
    }
    @custom_data = make CustomDataObject, defaults.merge(opts)
    @custom_data.create
  end

  def add_cost_sharing opts={}
    @cost_sharing.add merge_settings(opts)
    add_observer(@cost_sharing[-1])
  end

  def add_unrecovered_fa opts={}
    # TODO: Finish this method!
    opts.store(:index, bogus_value)
    @unrecovered_fa.add merge_settings(opts)
    add_observer(@unrecovered_fa[-1])
  end

  def add_project_personnel opts={}
    @project_personnel.add merge_settings(opts)
    add_observer(@project_personnel[-1])
  end

  def unlock_award(award_id)
    view :institutional_proposal
    on InstitutionalProposal do |page|
      page.edit
      page.institutional_proposal_actions
    end
    on InstitutionalProposalActions do |page|
      page.expand_all
      page.funded_award(award_id).set
      page.unlock_selected
      confirmation
      page.save
      if @document_id != page.document_id
        @document_id=page.document_id
        changed
        notify_observers(@document_id)
      end
    end
  end

  def submit
    view :institutional_proposal_actions
    on(InstitutionalProposalActions).submit
  end

  # =========
  private
  # =========

  def set_sponsor_code
    if @sponsor_id=='::random::'
      on(InstitutionalProposal).find_sponsor_code
      on SponsorLookup do |look|
        look.sponsor_type_code.pick! '::random::'
        look.search
        look.page_links[rand(look.page_links.length)].click if look.page_links.size > 0
        look.return_random
      end
      @sponsor_id=on(InstitutionalProposal).sponsor_id.value
    else
      on(InstitutionalProposal).sponsor_id.fit @sponsor_id
    end
  end

  def merge_settings(opts)
    defaults = {
        proposal_number: @proposal_number,
        document_id: @document_id,
        lookup_class: @lookup_class,
        search_key: @search_key,
        doc_header: @doc_header
    }
    opts.merge!(defaults)
  end

end