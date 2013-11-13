class AwardReportsObject < DataObject

  attr_accessor :financial, :intellectual_property,
                :procurement, :property

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        financial:             [{type: '::random::'}], # TODO: support the other report fields here.
        intellectual_property: [{type: '::random::'}],
        procurement:           [{type: '::random::'}],
        property:              [{type: '::random::'}],
        proposals_due:         [{type: '::random::'}],
        technical_management:  [{type: '::random::'}]
    }
    set_options(defaults.merge(opts))
  end

  def create
    on PaymentReportsTerms do |page|
      page.expand_all
      @financial.each { |f| page.financial_report_type.pick! f[:type]; page.add_financial_report }
      @intellectual_property.each { |ip| page.intellectual_property_report_type.pick! ip[:type]; page.add_intellectual_property_report }
      @procurement.each { |pro| page.procurement_report_type.pick! pro[:type]; page.add_procurement_report }
      @property.each { |prop| page.property_report_type.pick! prop[:type]; page.add_property_report }
      @proposals_due.each { |prop| page.proposals_due_report_type.pick! prop[:type]; page.add_proposals_due_report }
      @technical_management.each { |tm| page.technical_management_report_type.pick! tm[:type]; page.add_technical_management_report }
      page.save
    end
  end

end