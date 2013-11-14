class AwardFARatesObject < DataObject

  include DateFactory
  include StringFactory

  attr_accessor :rate, :type, :fiscal_year, :start_date, :end_date,
                :campus, :source, :destination, :unrecovered_fa

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
    }
    set_options(defaults.merge(opts))
  end

  def create

  end

end

class AwardFARatesCollection < CollectionsFactory

  contains AwardFARatesObject

end