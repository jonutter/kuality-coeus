class BudgetPeriodObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :document_id, :budget_name, :number, :start_date, :end_date,
                :total_sponsor_cost, :direct_cost, :f_and_a_cost, :unrecovered_f_and_a,
                :cost_sharing, :cost_limit, :direct_cost_limit, :datified

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
      total_sponsor_cost: '0.00',
      direct_cost: '0.00',
      f_and_a_cost: '0.00',
      unrecovered_f_and_a: '0.00',
      cost_sharing: '0.00',
      cost_limit:'0.00',
      direct_cost_limit: '0.00'
    }
    set_options(defaults.merge(opts))
    requires @document_id, @budget_name
  end

  def create
    # ...
    @datified=Date.parse(fixdate(@start_date))
  end

  def edit opts={}
    navigate
    # ...
    set_options(opts)
    @datified=Date.parse(fixdate(@start_date))
  end

  def delete
    navigate
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate

  end

  def fixdate(date_string)
    date_string[/(?<=\/)\d+$/] + '/' + date_string[/^\d+\/\d+/]
  end

end # BudgetPeriodObject

class BudgetPeriodsCollection < Array

  def new_number
    self.size + 1
  end

  def period(number)
    self.find { |period| period.number==number }
  end

  # This will update the number values of the budget periods,
  # based on their start date values.
  def re_sort!
    self.sort_by! { |period| period.datified }
    self.each_with_index { |period, index| period.store(:number, index+1) }
  end

end # BudgetPeriodCollection