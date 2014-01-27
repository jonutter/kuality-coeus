class CostSharingObject < DataObject

  include StringFactory

  attr_accessor :project_period, :percentage, :source_account, :amount,
                # Note: Indexing is zero-based!
                :index

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        percentage:     '0.00',
        source_account: random_alphanums
    }
    set_options(defaults.merge(opts))
  end

  def create
    view
    on DistributionAndIncome do |page|
      page.expand_all
      page.add_cost_share_period.fit @project_period
      page.add_cost_share_percentage.fit @percentage
      page.add_cost_share_source_account.fit @source_account
      page.add_cost_share_amount.fit @amount
      page.add_cost_share
      page.save
    end
  end

  def view
    # Note: Currently assumes we're already viewing
    # the budget document!
    on(Parameters).distribution__income
  end

  def edit(opts)
    view
    on DistributionAndIncome do |page|
      page.expand_all
      page.cost_sharing_project_period(@index).fit opts[:project_period]
      page.cost_sharing_percentage(@index).fit opts[:percentage]
      page.cost_sharing_source_account(@index).fit opts[:source_account]
      page.cost_sharing_amount(@index).fit opts[:amount]
      page.save
    end
    update_options(opts)
  end

end

class CostSharingCollection < CollectionsFactory

  contains CostSharingObject

  #TODO: Write code that will update indexes when items change their order in the list.

  def total_funds
    self.collect{ |cs| cs.amount.to_f}.inject(0, :+)
  end

end