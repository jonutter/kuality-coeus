class FinancialEntityObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :entity_name, :type, :sponsor_code, :status_code, :held,
                :address_line_1, :sponsor_research, :city, :country, :postal_code,
                :principal_activity

  def initialize(browser, opts={})
    @browser=browser
    defaults = {
      entity_name:        random_alphanums,
      type:               '::random::',
      address_line_1:     random_alphanums,
      sponsor_research:   'Y',
      status_code:        '::random::',
      held:               '::random::',
      city:               random_alphanums,
      country:            '::random::',
      postal_code:        '85028',
      principal_activity: random_multiline
    }
    set_options(defaults.merge(opts))
  end

  def create
    navigate
    on NewFinancialEntity do |page|
      fill_out page, :entity_name, :type, :address_line_1, :sponsor_research,
               :status_code, :city, :postal_code, :principal_activity, :held,
               :sponsor_research
      page.country_code.pick! @country
      page.submit
    end
  end

  # =========
  private
  # =========

  def navigate

  end

end