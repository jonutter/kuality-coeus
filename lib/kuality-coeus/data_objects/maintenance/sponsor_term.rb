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
        ## TODO: 'Random Alphanums' won't work for this field, because it only allows numbers
        ## Also, this field requires a unique term id, and that has yet to be resolved.
        sponsor_term_id:          dateTime.now,
        sponsor_term_code:        '1',
        sponsor_term_type_code:   '::random::',
        sponsor_term_description: random_alphanums,

    }
    set_options(defaults.merge(opts))
  end

  def create
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