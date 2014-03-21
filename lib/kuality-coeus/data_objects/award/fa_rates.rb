class AwardFARatesObject < DataFactory

  include DateFactory
  include StringFactory

  attr_reader :rate, :type, :fiscal_year, :start_date, :end_date,
                :campus, :source, :destination, :unrecovered_fa

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        rate:           rand(101).to_s,
        type:           '::random::',
        fiscal_year:    right_now[:year],
        start_date:     right_now[:date_w_slashes],
        campus:         '::random::',
        source:         random_alphanums,
        destination:    random_alphanums,
        unrecovered_fa: random_dollar_value(99999)
    }
    set_options(defaults.merge(opts))
  end

  def create
    # Currently navigation is handled by the AwardObject
    on Commitments do |page|
      page.expand_all
      page.new_rate.fit @rate
      page.new_rate_type.fit @type
      page.new_rate_fiscal_year.fit @fiscal_year
      page.new_rate_start_date
      page.add_rate
    end
  end

end

class AwardFARatesCollection < CollectionsFactory

  contains AwardFARatesObject

end