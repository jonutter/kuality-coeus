class BudgetColumnObject < DataObject

  include StringFactory
  include Navigation

  attr_accessor :name, :has_lookup, :lookup_argument, :lookup_return, :save_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        name:            '::random::',
        has_lookup:      :set,
        lookup_argument: '::random::',
        lookup_return:   '::random::',
        save_type:       :blanket_approve
    }

    set_options(defaults.merge(opts))
  end

  def create
    if exists?
      edit has_lookup: @has_lookup, lookup_argument: @lookup_argument,
           lookup_return: @lookup_return
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
        create.send(@save_type)
      end
    end
  end

  def view(in_class=false)
    if in_class
      # add navigation code here, because we're using this method outside
      # of the class methods
    end
    on(BudgetColumnsToAlterLookup).edit_first_item
  end

  def edit opts={}
    view(true)
    on BudgetColumnToAlter do |edit|
      edit.description.set random_alphanums
      edit.has_lookup.fit opts[:has_lookup]
      # Note: The next two lines of code are here because the
      # lookup return select list is blank
      # until the lookup argument field gets updated.
      edit.lookup_argument.select 'select'
      opts[:lookup_argument] ||= @lookup_argument
      edit.lookup_argument.pick! opts[:lookup_argument]
      edit.lookup_return.pick! opts[:lookup_return]
      edit.blanket_approve
    end
    update_options opts
  end

  def exists?
    # TODO: This will need to be made more robust at some point because not every user will have permissions
    # To keep it simple for now, just be sure this code is run very early in scenarios.
    $users.admin.log_in if $users.current_user==nil
    visit Maintenance do |page|
      if Login.new(@browser).username.present?
        UserObject.new(@browser).log_in
      end
      page.budget_editable_columns
    end
    on BudgetColumnsToAlterLookup do |look|
      look.column_name.select @name
      look.search

      begin
        if look.results_table.present?
          return true
        else
          return false
        end
      rescue
        return false
      end

    end
  end

end