class BudgetColumnObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :name, :has_lookup, :lookup_argument, :lookup_return

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        name:            '::random::',
        has_lookup:      :set,
        lookup_argument: '::random::',
        lookup_return:   '::random::'
    }

    set_options(defaults.merge(opts))
  end

  def create
    if exists?
      # We need to validate that the existing settings match
      # this
      view(true)
      on BudgetColumnToAlter do |edit|
        edit.has_lookup.fit @has_lookup
        edit.lookup_argument.pick! @lookup_argument
        edit.lookup_return.pick! @lookup_return
        edit.description.set random_alphanums
        edit.blanket_approve
      end
    else
      on(BudgetColumnsToAlterLookup).create
      on BudgetColumnToAlter do |create|
        create.description.set random_alphanums
        # Note: can't use fill_out here because field
        # selection can't be in a random order.
        create.name.pick! @name
        create.has_lookup.fit @has_lookup
        create.lookup_argument.pick! @lookup_argument
        create.lookup_return.pick! @lookup_return
        create.blanket_approve
      end
    end
  end

  def view(in_create=false)
    if in_create
      # add navigation code here, because we're using this method outside
      # of the create method
    end
    on(BudgetColumnsToAlterLookup).edit_first_item
  end

  def exists?
    # TODO: This will need to be made more robust at some point because not every user will have permissions
    # To keep it simple for now, just be sure this code is run very early in scenarios.
    visit Maintenance do |page|
      if Login.new(@browser).username.present?
        UserObject.new(@browser).log_in
      end
      page.budget_editable_columns
    end
    on BudgetColumnsToAlterLookup do |look|
      look.column_name.select @name
      look.search
    end
    begin
      if look.item_row(@name).present?
        return true
      else
        return false
      end
    rescue
      return false
    end
  end

end