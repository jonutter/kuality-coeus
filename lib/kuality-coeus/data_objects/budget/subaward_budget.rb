class SubawardBudgetObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :organization_id, :organization_id, :file_name, :direct_cost,
                :f_and_a_cost, :cost_sharing, :total_cost

  def initialize(browser, opts={})
    @browser = browser

    defaults = {}
    set_options(defaults.merge(opts))
  end

end

class SubawardBudgetCollection < Array



end