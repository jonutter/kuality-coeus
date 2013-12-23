class BudgetVersionsObject < DataObject

  include StringFactory
  include Navigation

  attr_accessor :name, :document_id, :status,
                # Stuff on Budget Versions page...
                :version, :direct_cost, :f_and_a, :on_off_campus,
                :total, :final, :residual_funds, :cost_sharing, :unrecovered_fa,
                :comments, :f_and_a_rate_type, :last_updated, :last_updated_by,
                # Stuff on the Parameters page...
                :project_start_date, :project_end_date, :total_direct_cost_limit,
                :budget_periods, :unrecovered_fa_rate_type, :f_and_a_rate_type,
                :submit_cost_sharing, :residual_funds, :total_cost_limit,
                :subaward_budgets, :personnel


  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      name:                           random_alphanums_plus(40),
      budget_periods:                 collection('BudgetPeriods'),
      subaward_budgets:               collection('SubawardBudget'),
      personnel:                      collection('BudgetPersonnel')
    }

    set_options(defaults.merge(opts))
    requires :document_id, :lookup_class
  end

  def create
    open_document
    on(Proposal).budget_versions unless on_page?(on(BudgetVersions).name)
    on BudgetVersions do |add|
      @doc_header=add.doc_title
      add.name.set @name
      add.add
      add.final(@name).fit @final
      add.budget_status(@name).pick! @status
      add.save
      break if parameters.compact==nil # No reason to continue if there aren't other things to do
      # Otherwise, go to parameters page and fill out the rest of the stuff...
      add.open(@name)
    end
    #TODO: This needs to be dealt with more intelligently.
    # It's clear that we need to learn more about how to set up
    # sponsors better, so that we can predict when this dialog
    # will show up and when it won't...
    confirmation
    on Parameters do |parameters|
      @project_start_date=parameters.project_start_date
      @project_end_date=parameters.project_end_date
      parameters.total_direct_cost_limit.fit @total_direct_cost_limit
      fill_out parameters, :comments, :modular_budget,
               :residual_funds, :total_cost_limit, :unrecovered_fa_rate_type,
               :f_and_a_rate_type, :submit_cost_sharing
      parameters.on_off_campus.fit @on_off_campus
      parameters.alert.ok if parameters.alert.exists?
      parameters.save
    end
    confirmation
    get_budget_periods
  end

  def add_period opts={}
    defaults={
        budget_name: @name,
        doc_header: @doc_header,
        lookup_class: @lookup_class,
        search_key: @search_key,
        start_date: @project_start_date
    }
    @budget_periods.add defaults.merge(opts)
    return if on(Parameters).errors.size > 0 # No need to continue the method if we have an error
    @budget_periods.number! # This updates the number value of all periods, as necessary
  end

  def edit_period number, opts={}
    @budget_periods.period(number).edit opts
    @budget_periods.number!
  end

  def delete_period number
    @budget_periods.period(number).delete
    @budget_periods.delete(@budget_periods.period(number))
    @budget_periods.number!
  end

  # Please note, this method is for VERY basic editing...
  # Use it for editing the Budget Version while on the Proposal, but not the Periods
  def edit opts={}
    open_budget
    on Parameters do |edit|
      edit.final.fit opts[:final]
      edit.budget_status.fit opts[:status]
      edit.total_direct_cost_limit.fit opts[:total_direct_cost_limit]
      # TODO: More to add here...
      edit.save
    end
    set_options(opts)
  end

  def open_budget
    open_document
    on(Proposal).budget_versions unless on_page?(on(BudgetVersions).name)
    on(BudgetVersions).open @name
    #TODO: This needs to be dealt with more intelligently.
    # It's clear that we need to learn more about how to set up
    # sponsors better, so that we can predict when this dialog
    # will show up and when it won't...
    confirmation
  end

  def copy_all_periods(new_name)
    open_document
    on(Proposal).budget_versions unless on_page?(on(BudgetVersions).name)
    new_version_number='x'
    on(BudgetVersions).copy @name
    on(Confirmation).copy_all_periods
    on BudgetVersions do |copy|
      copy.name_of_copy.set new_name
      copy.save
      new_version_number=copy.version(new_name)
    end
    new_bv = self.clone
    new_bv.name=new_name
    new_bv.version=new_version_number
    new_bv
  end

  def copy_one_period(new_name, version)
    # pending resolution of a bug
  end

  def default_periods
    open_budget
    on Parameters do |page|
      page.parameters unless page.parameters_button.parent.class_name=='tabright tabcurrent'
      page.default_periods
    end
    @budget_periods.clear
    get_budget_periods
  end

  def add_subaward_budget(opts={})
    open_budget
    on(Parameters).budget_actions
    sab = make SubawardBudgetObject, opts
    sab.create
    @subaward_budgets << sab
  end

  def add_project_personnel(opts={})
    open_budget
    on(Parameters).personnel
    person = make BudgetPersonnelObject, opts
    person.create
    @personnel << person
  end

  # =======
  private
  # =======

  # This is just a collection of the instance variables
  # associated with the Parameters page. It's used to determine
  # whether or not the create method should go to that page
  # and fill stuff out.
  def parameters
    [@total_direct_cost_limit, @on_off_campus, @comments, @modular_budget,
     @residual_funds, @total_cost_limit, @unrecovered_fa_rate_type, @f_and_a_rate_type,
     @submit_cost_sharing]
  end

  def get_budget_periods
    on Parameters do |page|
      @doc_header=page.doc_title
      1.upto(page.period_count) do |number|
        period = make BudgetPeriodObject, document_id: @document_id,
                      budget_name: @name, start_date: page.start_date_period(number).value,
                      end_date: page.end_date_period(number).value,
                      total_sponsor_cost: page.total_sponsor_cost_period(number).value.groom,
                      direct_cost: page.direct_cost_period(number).value.groom,
                      f_and_a_cost: page.fa_cost_period(number).value.groom,
                      unrecovered_f_and_a: page.unrecovered_fa_period(number).value.groom,
                      cost_sharing: page.cost_sharing_period(number).value.groom,
                      cost_limit: page.cost_limit_period(number).value.groom,
                      direct_cost_limit: page.direct_cost_limit_period(number).value.groom,
                      lookup_class: @lookup_class,
                      doc_header: @doc_header
        @budget_periods << period
      end
    end
    @budget_periods.number!
  end

end # BudgetVersionsObject

class BudgetVersionsCollection < CollectionsFactory

  contains BudgetVersionsObject

  def budget(name)
    self.find { |budget| budget.name==name }
  end

  def copy_all_periods(name, new_name)
    self << self.budget(name).copy_all_periods(new_name)
  end

end # BudgetVersionsCollection