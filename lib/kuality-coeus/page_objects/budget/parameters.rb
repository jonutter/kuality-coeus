class Parameters < BudgetDocument

  #Budget Overview
  value(:project_start_date) { |p| p.bo_table[0][1].text }
  value(:project_end_date) { |p| p.bo_table[1][1].text }
  element(:total_direct_cost_limit) { |b| b.frm.text_field(name: 'document.budget.totalDirectCostLimit') }
  element(:on_off_campus) { |b| b.frm.select(name: 'document.budget.onOffCampusFlag') }
  element(:comments) { |b| b.frm.text_field(name: 'document.budget.comments') }
  element(:budget_status) { |b| b.frm.select(name: 'document.budget.budgetStatus') }
  element(:final) { |b| b.frm.checkbox(name: 'document.budget.finalVersionFlag') }
  element(:modular_budget) { |b| b.frm.checkbox(name: 'document.budget.modularBudgetFlag') }
  element(:residual_funds) { |b| b.frm.text_field(name: 'document.budget.residualFunds') }
  element(:total_cost_limit) { |b| b.frm.text_field(name: 'document.budget.totalCostLimit') }
  element(:unrecovered_fa_rate_type) { |b| b.frm.select(name: 'document.budget.urRateClassCode') }
  element(:f_and_a_rate_type) { |b| b.frm.select(name: 'document.budget.ohRateClassCode') }
  element(:submit_cost_sharing) { |b| b.frm.checkbox(name:'document.budget.submitCostSharingFlag') }

  #Adding new budget period
  element(:period_start_date) { |b| b.frm.text_field(name: 'newBudgetPeriod.startDate') }
  element(:period_end_date) { |b| b.frm.text_field(name: 'newBudgetPeriod.endDate') }
  element(:total_sponsor_cost) { |b| b.frm.text_field(name: 'newBudgetPeriod.totalCost') }
  element(:direct_cost) { |b| b.frm.text_field(name: 'newBudgetPeriod.totalDirectCost') }
  element(:fa_cost) { |b| b.frm.text_field(name: 'newBudgetPeriod.totalIndirectCost') }
  alias_method :f_and_a_cost, :fa_cost
  element(:unrecovered_fa_cost) { |b| b.frm.text_field(name: 'newBudgetPeriod.underrecoveryAmount') }
  element(:cost_sharing) { |b| b.frm.text_field(name: 'newBudgetPeriod.costSharingAmount') }
  element(:cost_limit) { |b| b.frm.text_field(name: 'newBudgetPeriod.totalCostLimit') }
  element(:direct_cost_limit) { |b| b.frm.text_field(name: 'newBudgetPeriod.directCostLimit') }
  action(:add_budget_period) { |b| b.frm.button(name:'methodToCall.recalculateBudgetPeriod.anchorBudgetPeriodsTotals').click }

  # These are for editing existing budget periods,
  # based on the number in the left-most column.
  action(:start_date_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].startDate") }
  action(:end_date_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].endDate") }
  action(:total_sponsor_cost_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].totalCost") }
  action(:direct_cost_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].totalDirectCost") }
  action(:f_and_a_cost_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].totalIndirectCost") }
  alias_method :fa_cost_period, :f_and_a_cost_period
  action(:unrecovered_fa_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].underrecoveryAmount") }
  alias_method :unrecovered_f_and_a_period, :unrecovered_fa_period
  action(:cost_sharing_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].costSharingAmount") }
  action(:cost_limit_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].totalCostLimit") }
  action(:direct_cost_limit_period) { |period, b| b.frm.text_field(id: "document.budget.budgetPeriods[#{period-1}].directCostLimit") }
  action(:delete_period) { |period, b| b.frm.button(name: "methodToCall.deleteBudgetPeriod.line#{period-1}.anchor12").click }

  value(:period_count) { |b| b.frm.text_fields(title: 'Period Start Date').size-1 }

  action(:recalculate) { |b| b.frm.button(name: 'methodToCall.recalculateBudgetPeriod.anchorBudgetPeriodsTotals').click }

  element(:warnings) do |b|
    warns = []
    b.tab_containers.each do |div|
      if div.li.exist?
        warns << div.lis.collect{ |li| li.text }
      end
    end
    warns.flatten
  end

  # =======
  private
  # =======

  element(:bo_table) { |b| b.frm.div(id: 'tab-BudgetOverview-div').table }

  element(:tab_containers) { |b| b.divs(class: 'tab-container') }

end