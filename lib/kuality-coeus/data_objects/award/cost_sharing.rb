class AwardCostSharingObject < DataObject

  include DateFactory
  include StringFactory

  attr_accessor :percentage, :type, :project_period, :source,
                :destination, :commitment_amount, :cost_share_met,
                :verification_date

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
    }
    set_options(defaults.merge(opts))
  end

  def create

  end

end

class AwardCostSharingCollection < CollectionsFactory

  contains AwardCostSharingObject

end