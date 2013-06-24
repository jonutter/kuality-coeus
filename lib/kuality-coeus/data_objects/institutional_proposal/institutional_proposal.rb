class InstitutionalProposalObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation

  attr_accessor :document_id, :proposal_number, :title, :doc_status, :sponsor_id, :activity_type,
                :proposal_type, :proposal_status, :key_personnel, :custom_data, :special_review,
                :initiator

  def initialize(browser, opts={})
    @browser = browser
    set_options(opts)
  end



end