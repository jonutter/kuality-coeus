class SponsorTemplateObject < DataFactory

  include StringFactory

  attr_reader :doc_nbr, :description, :template_description, :template_status, :payment_basis,
              :payment_method, :sponsor_term_lookup

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums,
        payment_basis:  '::random::',
        payment_method: '::random::',

    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(Maintenance).sponsor_template
    on(SponsorTemplateLookup).create
    on SponsorTemplate do |add|
      @doc_nbr=add.doc_nbr
      add.expand_all
      fill_out add, :description, :template_description, :payment_basis, :payment_method
      add.submit
    end
  end

end