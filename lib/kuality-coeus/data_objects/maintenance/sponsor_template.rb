class SponsorTemplateObject < DataFactory

  include StringFactory

  attr_reader :payment_basis, :payment_method, :save_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:    random_alphanums,
        payment_basis:  '::random::',
        payment_method: '::random::'
    }
    set_options(defaults.merge(opts))
  end

  def create
    $users.admin.sign_in unless $users.admin.logged_in?
    visit(Maintenance).sponsor_template
    on(SponsorTemplateLookup).create
    on SponsorTemplate do |add|
      add.expand_all
      fill_out add, :description, :payment_basis, :payment_method
      add.save
    end
  end

end