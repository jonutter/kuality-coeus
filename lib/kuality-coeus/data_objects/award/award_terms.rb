class AwardTermsObject < DataFactory

  attr_reader :equipment_approval, :invention, :prior_approval, :property,
                :publication, :referenced_document, :rights_in_data,
                :subaward_approval, :travel_restrictions

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        equipment_approval:  [rand(1..28)],
        invention:           [rand(1..22)],
        prior_approval:      [rand(1..58)],
        property:            [rand(1..27)],
        publication:         [rand(1..15)],
        referenced_document: [rand(1..70)],
        rights_in_data:      [rand(1..37)],
        subaward_approval:   [rand(1..24)],
        travel_restrictions: [rand(1..25)]
    }
    set_options(defaults.merge(opts))
  end

  def create
    on PaymentReportsTerms do |page|
      page.expand_all
      @equipment_approval.each { |ea| page.equipment_approval_code.fit ea; page.add_equipment_approval_term }
      @invention.each {|inv| page.invention_code.fit inv; page.add_invention_term }
      @prior_approval.each { |pa| page.prior_approval_code.fit pa; page.add_prior_approval_term }
      @property.each { |prop| page.property_code.fit prop; page.add_property_term }
      @publication.each { |pub| page.publication_code.fit pub; page.add_publication_term }
      @referenced_document.each { |ref| page.referenced_document_code.fit ref; page.add_referenced_document_term }
      @rights_in_data.each { |rid| page.rights_in_data_code.fit rid; page.add_rights_in_data_term }
      @subaward_approval.each { |sa| page.subaward_approval_code.fit sa; page.add_subaward_approval_term }
      @travel_restrictions.each { |tr| page.travel_restrictions_code.fit tr; page.add_travel_restrictions_term }
      page.save
    end
  end

end