class FundsDistributionObject < DataFactory

  include StringFactory
  include DateFactory

  attr_reader :start_date, :end_date, :direct_cost, :fa_cost
  attr_accessor :number

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
       start_date:  in_a_week[:date_w_slashes],
       end_date:    in_a_year[:date_w_slashes],
       direct_cost: random_dollar_value(1000),
       fa_cost:     random_dollar_value(1000)
    }
    set_options(defaults.merge(opts))
  end

  def create

  end

end # FundsDistribution

class FundsDistributionCollection < CollectionFactory

  contains FundsDistributionObject

end # FundsDistributionCollection