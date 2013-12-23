class InstitutionalProposalObject < DataObject

  include StringFactory
  include DateFactory
  include Navigation
  include DocumentUtilities

  attr_accessor :document_id, :proposal_number, :dev_proposal_number, :project_title,
                :doc_status, :sponsor_id, :activity_type, :proposal_type, :proposal_status,
                :project_personnel, :custom_data, :special_review, :cost_sharing,
                :award_id, :initiator, :proposal_log, :unrecovered_fa,
                :key_personnel, :nsf_science_code

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        proposal_status:   'Pending',
        activity_type:     '::random::',
        sponsor_id:        '::random::',
        project_personnel: collection('ProjectPersonnel'),
        special_review:    collection('SpecialReview'),
        cost_sharing:      collection('IPCostSharing'),
        unrecovered_fa:    collection('IPUnrecoveredFA')
    }
    unless opts[:proposal_log].nil?
      defaults[:proposal_type]=opts[:proposal_log].proposal_type
      defaults[:project_title]=opts[:proposal_log].title
      defaults[:sponsor_id]=opts[:proposal_log].sponsor_id
      pi = make ProjectPersonnelObject, principal_name: opts[:proposal_log].principal_investigator,
                role: 'Principal Investigator'
      defaults[:project_personnel] << pi
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
      create.description.set random_alphanums
      fill_out create, :proposal_type, :award_id, :activity_type, :project_title
      set_sponsor_code
      create.save
    end
  end

  def view(tab)
    open_document
    on(InstitutionalProposal).send(StringFactory.damballa(tab.to_s))
  end

  def add_custom_data opts={}
    @custom_data = prep(CustomDataObject, opts)
  end

  def add_cost_sharing opts={}
    @cost_sharing.add merge_settings(opts)
  end

  def add_unrecovered_fa opts={}
    @unrecovered_fa.add merge_settings(opts)
  end

  def add_project_personnel opts={}
    @project_personnel.add merge_settings(opts)
  end

  def unlock_award(award_id)
    view :institutional_proposal
    on(InstitutionalProposal).edit # TODO: IMPORTANT!!! Code update to document number because of this edit!!!
    on InstitutionalProposalActions do |page|
      page.expand_all
      page.funded_award(award_id).set
      page.unlock_selected







sleep 45









    end
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
        doc_header: @doc_header
    }
    opts.merge!(defaults)
  end

  def prep(object_class, opts)
    merge_settings(opts)
    object = make object_class, opts
    object.create
    object
  end

end