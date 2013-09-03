class CostSharingCollection < Array



end

class CostSharingObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :project_period, :percentage, :source_account, :amount

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        project_period: '1',
        percentage:     '0.00',
        source_account: random_alphanums
    }
    set_options(defaults.merge(opts))
  end

  def create
    on DistributionAndIncome do |page|
      page.add_cost_share_period.set @project_period
      # TODO: Add more here when needed
      page.add
    end
  end

  def view
    # TODO
  end

  def edit(opts)
    on DistributionAndIncome do |page|
      page.expand_all
      page.cost_sharing_project_period.fit opts[:project_period]
      page.cost_sharing_percentage.fit opts[:percentage]
      page.cost_sharing_source_account.fit opts[:source_account]
      page.cost_sharing_amount.fit opts[:amount]
      page.save
    end
    update_options(opts)
  end

end