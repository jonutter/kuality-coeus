class SubawardBudgetObject < DataObject

  include StringFactory
  include Navigation

  attr_accessor :organization_name, :organization_id, :file_name, :direct_cost,
                :f_and_a_cost, :cost_sharing, :total_cost

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        file_name:    'test.pdf',
        direct_cost:  random_dollar_value(10000),
        f_and_a_cost: random_dollar_value(10000),
        cost_sharing: random_dollar_value(10000)
    }
    set_options(defaults.merge(opts))
  end

  def create
    # As this is a nested object, it should be created
    # by its parent. So,  we're having the
    # parent BudgetVersionsObject
    # do the navigation for us...
    on(BudgetActions).expand_all
    if @organization_id.nil?
      on(BudgetActions).look_up_organization
      on OrganizationLookup do |look|
        look.search
        look.return_random
      end
      on BudgetActions do |add|
        @organization_id=add.add_organization_id.value
        # The next two lines are needed because
        # otherwise the organization name will not
        # appear in the div...
        add.add_organization_id.focus
        add.add_comments.focus
        @organization_name=add.organization_name
      end
    else
      # TODO Write this else clause when it's necessary
    end
    on BudgetActions do |add|
      add.add_file_name.set($file_folder+@file_name)
      add.add_subaward_budget
      add.show_details @organization_name
      fill_out_item @organization_name, add, :direct_cost, :f_and_a_cost, :cost_sharing
      @total_cost=add.total_cost(@organization_name)
      add.save
    end
  end

end

class SubawardBudgetCollection < CollectionsFactory

  contains SubawardBudgetObject

end