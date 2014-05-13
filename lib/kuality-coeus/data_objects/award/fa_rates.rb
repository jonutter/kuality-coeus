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
        fiscal_year:    date_factory(Time.random(year_range: 500))[:year],
        campus:         '::random::',
        source:         random_alphanums_plus,
        destination:    random_alphanums_plus,
        unrecovered_fa: random_dollar_value(99999)
    }
    set_options(defaults.merge(opts))
  end

  def create
    # Currently navigation is handled by the AwardObject
    on Commitments do |page|
      page.expand_all
      page.new_rate.fit @rate
      page.new_rate_type.pick! @type

      if @start_date
        page.new_rate_fiscal_year.fit @fiscal_year
        page.new_rate_start_date.set @start_date
        page.new_rate_end_date.set @end_date
      else
        page.new_rate_fiscal_year.send_keys @fiscal_year.to_s
        page.new_rate_fiscal_year.send_keys :tab
        page.wait_until { page.new_rate_start_date.value != '' }
        @start_date=page.new_rate_start_date.value
        @end_date=page.new_rate_end_date.value
      end
      page.new_rate_source.fit @source
      page.new_rate_campus.pick! @campus
      page.new_rate_destination.fit @destination
      page.new_rate_unrecovered_fa.fit @unrecovered_fa
      # Added this line for testing a blank start date field...
      page.new_rate_start_date.clear if @start_date==''
      page.add_rate
    end
  end

end

class AwardFARatesCollection < CollectionsFactory

  contains AwardFARatesObject

end