class BudgetPeriodObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :number, :start_date, :end_date, :total_sponsor_cost,
                :direct_cost, :f_and_a_cost, :unrecovered_f_and_a,
                :cost_sharing, :cost_limit, :direct_cost_limit, :datified,
                :budget_name, :cost_sharing_distribution_list

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      doc_type: 'Budget Document ', # Note: the trailing space is not a typo!
      cost_sharing_distribution_list: collection('CostSharing')
    }

    set_options(defaults.merge(opts))
    requires :start_date, :budget_name
    datify
    add_cost_sharing @cost_sharing
  end

  def create
    navigate
    on Parameters do |create|
      create.period_start_date.fit @start_date
      create.period_end_date.fit @end_date
      create.total_sponsor_cost.fit @total_sponsor_cost
      fill_out create, :direct_cost, :cost_sharing, :cost_limit, :direct_cost_limit
      create.fa_cost.fit @f_and_a_cost
      create.unrecovered_fa_cost.fit @unrecoverd_f_and_a
      create.add_budget_period
    end
  end

  def edit opts={}
    navigate
    on Parameters do |edit|
      edit.start_date_period(@number).fit opts[:start_date]
      edit.end_date_period(@number).fit opts[:end_date]
      # TODO: At some point it may become critical for the data object to automatically "know" that the total sponsor cost
      # is always the sum of the direct and f&a costs.
      dollar_fields.each do |field|
        edit.send("#{field}_period", @number).fit opts[field]
      end
      edit.save
      break if edit.errors.size > 0
    end
    set_options(opts)
    datify
    add_cost_sharing opts[:cost_sharing]
  end

  def delete
    navigate
    on(Parameters).delete_period @number
  end

  def dollar_fields
    [:total_sponsor_cost, :direct_cost, :f_and_a_cost, :unrecovered_f_and_a,
     :cost_sharing, :cost_limit, :direct_cost_limit]
  end

  # =======
  private
  # =======

  # Nav Aids

  def navigate
    open_document @doc_type
    unless on_page?(on(Parameters).on_off_campus) && on_budget?
      on(Proposal).budget_versions
      on(BudgetVersions).open @budget_name
    end
  end

  def on_budget?
    begin
      on(Parameters).budget_name==@budget_name
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      false
    end
  end

  # This takes the period start date and converts it into a Date object
  # which is then stored in @datified.
  #
  # It's important in the context of the Budget Periods Collection,
  # which uses it to determine the order of the Periods on the page.
  def datify
    @datified=Date.parse(@start_date[/(?<=\/)\d+$/] + '/' + @start_date[/^\d+\/\d+/])
  end

  def add_cost_sharing(cost_sharing)
    if !cost_sharing.nil? && cost_sharing.to_f > 0
      cs = make CostSharingObject, project_period: @number,
                amount: cost_sharing, source_account: '',
                index: @cost_sharing_distribution_list.length
      @cost_sharing_distribution_list << cs
    end
  end

end # BudgetPeriodObject

class BudgetPeriodsCollection < CollectionsFactory

  contains BudgetPeriodObject

  def period(number)
    self.find { |period| period.number==number }
  end

  # This will update the number values of the budget periods,
  # based on their start date values.
  def number!
    self.sort_by! { |period| period.datified }
    self.each_with_index { |period, index| period.number=index+1 }
  end

  def total_sponsor_cost
    self.collect{ |period| period.total_sponsor_cost.to_f }.inject(0, :+)
  end

end # BudgetPeriodsCollection