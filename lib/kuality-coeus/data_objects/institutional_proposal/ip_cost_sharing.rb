class IPCostSharingObject < DataFactory

  include StringFactory
  include Navigation

  attr_reader :project_period, :percentage, :type,
                :source_account, :amount
  attr_accessor :index

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        project_period: '1',
        percentage:     '100.00',
        type:           '::random::',
        source_account: random_alphanums_plus,
        amount:         random_dollar_value(1000)
    }
    set_options(defaults.merge(opts))
  end

  def create
    view
    on Distribution do |page|
      page.expand_all
      page.add_cost_share_project_period.set @project_period
      page.add_cost_share_type.pick! @type
      page.add_cost_share_percentage.set @percentage
      page.add_cost_share_source_account.set @source_account
      page.add_cost_share_amount.set @amount
      page.add_cost_share
    end
  end

  def view
    # Note: Currently assumes we're already viewing
    # the institutional proposal!
    on(InstitutionalProposal).distribution
  end

  def edit(opts)
    view
    on Distribution do |page|
      page.expand_all
      #TODO: Add this code
      page.save
    end
    update_options(opts)
  end

  def update(id)
    @document_id=id
  end

end

class IPCostSharingCollection < CollectionsFactory

  contains IPCostSharingObject

  #TODO: Write code that will update indexes when items change their order in the list.

end