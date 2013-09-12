class IRBProtocolDevelopmentObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation

  attr_accessor  :description, :organization_document_number, :protocol_type, :title, :lead_unit,
                 :other_identifier_type, :other_identifier_name, :organization_id, :organization_type,
                 :funding_type, :funding_number, :source, :participant_type, :document_id, :initiator,
                 :protocol_number, :status, :submission_status, :expiration_date

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums,
        protocol_type:  '::random::',
        title:          random_alphanums,
        lead_unit:      '::random::',
    }

    set_options(defaults.merge(opts))
  end

  def create
    window_cleanup
    visit(Researcher).create_irb_protocol
    on Protocol do |doc|
      #@doc_header=doc.doc_title
      @document_id=doc.document_id
      @status=doc.document_status
      @initiator=doc.initiator
      @submission_status=doc.submission_status
      @expiration_date=doc.expiration_date
      doc.expand_all
      fill_out doc, :description, :protocol_type, :title, :lead_unit
      doc_save
      @protocol_number=doc.protocol_number
    end
  end
end