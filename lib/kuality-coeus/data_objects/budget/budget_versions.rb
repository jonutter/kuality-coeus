class BudgetVersionsObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :name, :document_id, :status,
                # Stuff on Budget Versions page...
                :version, :direct_cost, :f_and_a,
                :total, :final, :residual_funds, :cost_sharing, :unrecovered_fa,
                :comments, :f_and_a_rate_type, :last_updated, :last_updated_by,
                # Stuff on the Parameters page...
                :project_start_date, :project_end_date, :total_direct_cost_limit,
                :budget_periods, :unrecovered_fa_rate_type, :f_and_a_rate_type,
                :submit_cost_sharing, :residual_funds, :total_cost_limit


  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      name:              random_alphanums,
      cost_sharing:      '0.00',
      f_and_a:           '0.00',
      f_and_a_rate_type: 'MTDC',
      budget_periods:    BudgetPeriodsCollection.new
    }

    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create
    navigate
    on BudgetVersions do |add|
      add.name.set @name
      add.add
      add.final(@name).fit @final
      add.status(@name).pick! @status
      add.save
      break if parameters.compact==nil # No reason to continue if there aren't other things to do
      # Otherwise, go to parameters page and fill out the rest of the stuff...
      add.open(@name)
    end
    on Parameters do |parameters|
      @project_start_date=parameters.project_start_date
      @project_end_date=parameters.project_end_date
      parameters.total_direct_cost_limit.fit @total_direct_cost_limit
      fill_out parameters, :on_off_campus, :comments, :modular_budget, :residual_funds,
                           :total_cost_limit, :unrecovered_fa_rate_type, :f_and_a_rate_type,
                           :submit_cost_sharing
      # Add the default Budget Period to the collection.
      # Note that this is only a make, since the item is already
      # there on the page.
      default_bp = make BudgetPeriodObject, document_id: @document_id, budget_name: @name, number: 1,
                        start_date: @project_start_date, end_date: @project_end_date
      @budget_periods << default_bp
      parameters.save
    end
  end

  def add_period opts={}
    defaults={
        document_id: @document_id,
        budget_name: @name
    }
    opts.merge!(defaults)

    bp = create BudgetPeriodObject, opts
    return if on(Parameters).errors.size > 0 # No need to continue the method if we have an error
    @budget_periods << bp
    @budget_periods.re_sort! # This updates the number value of all periods, as necessary
  end

  def edit_period number, opts
    @budget_periods.period(number).edit opts
    @budget_periods.re_sort!
  end

  def delete_period number
    @budget_periods.period(number).delete
    @budget_periods.re_sort!
  end

  # Use for editing the Budget Version, but not the Periods
  def edit opts={}
    navigate
    # TODO!
    set_options(opts)
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document unless on_document?
    on(Proposal).budget_versions unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(BudgetVersions).name.exist?
    rescue
      false
    end
  end

  # This is just a collection of the instance variables
  # associated with the Parameters page. It's used to determine
  # whether or not the create method should go to that page
  # and fill stuff out.
  def parameters
    [@total_direct_cost_limit, @on_off_campus, @comments, @modular_budget,
    @residual_funds, @total_cost_limit, @unrecovered_fa_rate_type, @f_and_a_rate_type,
    @submit_cost_sharing]
  end

end # BudgetVersionsObject

class BudgetVersionsCollection < Array

  def budget(name)
    self.find { |budget| budget.name==name }
  end

end # BudgetVersionsCollection