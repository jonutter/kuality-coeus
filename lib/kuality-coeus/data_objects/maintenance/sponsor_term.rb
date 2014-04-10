class SponsorTermObject < DataFactory

  include StringFactory
  include DateFactory
  include Navigation
  include DocumentUtilities

  attr_reader :document_id, :status, :description, :sponsor_term_id, :sponsor_term_code,
              :sponsor_term_type_code, :sponsor_term_description

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:              random_alphanums,
        sponsor_term_id:          '::random::',
        sponsor_term_code:        '1',
        sponsor_term_type_code:   '::random::',
        sponsor_term_description: random_alphanums,

    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(Maintenance).sponsor_terms
    on SponsorTermLookup do |page|
      page.search
      page.sort_sponsor_term_id
      page.last
      @sponsor_term_id = search.
      sleep 40
    end
    visit(Maintenance).sponsor_terms
    on(SponsorTermLookup).create
    on SponsorTerm do |add|
      @document_id=add.document_id
      @status=add.document_status
      add.expand_all
      fill_out add, :description, :sponsor_term_code, :sponsor_term_type_code,
                    :sponsor_term_description
      add.submit
    end
  end
end