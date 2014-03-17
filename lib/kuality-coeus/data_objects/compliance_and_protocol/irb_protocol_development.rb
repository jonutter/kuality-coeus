class IRBProtocolDevelopmentObject < DataFactory

  include StringFactory
  include DateFactory
  include Navigation

  attr_reader  :description, :organization_document_number, :protocol_type, :title, :lead_unit,
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
    # TODO: Needs a @lookup_class and @search_key defined
    set_options(defaults.merge(opts))
  end

  def create
    visit(Researcher).create_irb_protocol
    on ProtocolOverview do |doc|
      @document_id=doc.document_id
      @doc_header=doc.doc_title
      @status=doc.document_status
      @initiator=doc.initiator
      @submission_status=doc.submission_status
      @expiration_date=doc.expiration_date
      doc.expand_all
      fill_out doc, :description, :protocol_type, :title
    end
      set_lead_unit
      set_pi
    on ProtocolOverview do |doc|
      doc.save
      @protocol_number=doc.protocol_number
    end
  end

  # =======
  private
  # =======

  def merge_settings(opts)
    defaults = {
        document_id: @document_id,
        doc_header: @doc_header
    }
    opts.merge!(defaults)
  end

  def set_lead_unit
    if @lead_unit=='::random::'
      on(ProtocolOverview).find_lead_unit
      on UnitLookup do |look|
        look.search
        look.page_links[rand(look.page_links.length)].click if look.page_links.size > 0
        look.return_random
      end
      @lead_unit=on(ProtocolOverview).lead_unit.value
    else
      on(ProtocolOverview).lead_unit.fit @lead_unit
    end
  end

  def set_pi
    on(ProtocolOverview).pi_employee_search
    on PersonLookup do |look|
      look.search
      look.return_random
    end
  end

  def prep(object_class, opts)
    merge_settings(opts)
    object = make object_class, opts
    object.create
    object
  end

end