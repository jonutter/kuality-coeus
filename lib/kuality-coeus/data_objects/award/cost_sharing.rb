class AwardCostSharingObject < DataFactory

  include DateFactory
  include StringFactory

  attr_reader :percentage, :type, :project_period, :source,
              :destination, :commitment_amount, :cost_share_met,
              :verification_date

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        percentage:        rand(101).to_s,
        type:              '::random::',
        project_period:    '1',
        source:            random_alphanums_plus,
        commitment_amount: random_dollar_value(100000)
    }
    set_options(defaults.merge(opts))
  end

  def create
    # TODO: add conditional navigation (if necessary?)
    # Currently navigation is handled by the AwardObject
    on Commitments do |page|
      page.expand_all
      page.new_cost_sharing_percentage.fit @percentage
      page.new_cost_sharing_type.pick! @type
      page.new_cost_sharing_project_period.fit @project_period
      page.new_cost_sharing_source.fit @source
      page.new_cost_sharing_destination.fit @destination
      page.new_cost_sharing_commitment_amount.fit @commitment_amount
      page.add_cost_sharing
    end
  end

end

class AwardCostSharingCollection < CollectionsFactory

  contains AwardCostSharingObject

end