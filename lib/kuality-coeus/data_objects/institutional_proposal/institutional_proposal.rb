class InstitutionalProposalObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation

  attr_accessor :document_id, :proposal_number, :dev_proposal_number, :project_title, :doc_status, :sponsor_id, :activity_type,
                :proposal_type, :proposal_status, :project_personnel, :custom_data, :special_review, :award_id,
                :initiator, :proposal_log

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        proposal_status:   'Pending',
        activity_type:     '::random::',
        project_personnel: collection('ProjectPersonnel')
    }
    unless opts[:proposal_log].nil?
      defaults[:proposal_type]=opts[:proposal_log][:proposal_type]
      defaults[:project_title]=opts[:proposal_log][:title]
      defaults[:sponsor_id]=opts[:proposal_log][:sponsor_id]
      pi = make ProjectPersonnelObject, full_name: opts[:proposal_log][:full_name],
                role: 'Principal Investigator'
      defaults[:project_personnel] << pi
    end

    set_options(defaults.merge(opts))
  end

  # This method is appropriate only in the context of creating an
  # Institutional Proposal from a Proposal Log.
  def create

  end

end