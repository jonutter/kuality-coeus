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
      page.new_rate_type.pick! @type
      page.new_rate_fiscal_year.fit @fiscal_year
      if @start_date
        page.new_rate_start_date.set @start_date
        page.new_rate_end_date.set @end_date
        page.new_rate_source.fit @source
      else
        page.new_rate_fiscal_year.click
        page.new_rate_source.click
        page.new_rate_source.fit @source
        @start_date=page.new_rate_start_date.value
        @end_date=page.new_rate_end_date.value
      end
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