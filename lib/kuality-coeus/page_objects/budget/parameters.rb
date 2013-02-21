class Parameters < BasePage

  budget_header_elements
  global_buttons
  document_header_elements

  #Budget Overview
  value(:project_start_date) { |p| p.bo_table[0][1].text }
  value(:project_end_date) { |p| p.bo_table[1][1].text }
  element(:total_direct_cost_limit) { |b| b.frm.text_field(name: 'document.budget.totalDirectCostLimit') }
  element(:on_off_campus) { |b| b.frm.select(name: 'document.budget.onOffCampusFlag') }
  element(:comments) { |b| b.frm.text_field(name: 'document.budget.comments') }
  element(:final) { |b| b.frm.checkbox(name: 'document.budget.finalVersionFlag') }
  element(:modular_budget) { |b| b.frm.checkbox(name: 'document.budget.modularBudgetFlag') }
  element(:residual_funds) { |b| b.frm.text_field(name: 'document.budget.residualFunds') }
  element(:total_cost_limit) { |b| b.frm.text_field(name: 'document.budget.totalCostLimit') }
  element(:unrecovered_fa_rate_type) { |b| b.frm.select(name: 'document.budget.urRateClassCode') }
  element(:fa_rate_type) { |b| b.frm.select(name: 'document.budget.ohRateClassCode') }
  element(:submit_cost_sharing) { |b| b.frm.checkbox(name:'document.budget.submitCostSharingFlag') }

  #Adding new budget period
  element(:period_start_date) { |b| b.frm.text_field(name: 'newBudgetPeriod.startDate') }
  element(:period_end_date) { |b| b.frm.text_field(name: 'newBudgetPeriod.endDate') }
  element(:total_sponsor_cost) { |b| b.frm.text_field(name: 'newBudgetPeriod.totalCost') }
  element(:direct_cost) { |b| b.frm.text_field(name: 'newBudgetPeriod.totalDirectCost') }
  element(:fa_cost) { |b| b.frm.text_field(name: 'newBudgetPeriod.totalIndirectCost') }
  element(:unrecovered_fa_cost) { |b| b.frm.text_field(name: 'newBudgetPeriod.underrecoveryAmount') }
  element(:cost_sharing) { |b| b.frm.text_field(name: 'newBudgetPeriod.costSharingAmount') }
  element(:cost_limit) { |b| b.frm.text_field(name: 'newBudgetPeriod.totalCostLimit') }
  element(:direct_cost_limit) { |b| b.frm.text_field(name: 'newBudgetPeriod.directCostLimit') }
  action(:add_budget_period) { |b| b.frm.button(name:'methodToCall.recalculateBudgetPeriod.anchorBudgetPeriodsTotals').click }

  # TODO: Add methods for editing/deleting specific budget period lines.

  action(:recalculate) { |b| b.frm.button(name: 'methodToCall.recalculateBudgetPeriod.anchorBudgetPeriodsTotals').click }

  action(:generate_all_periods) { |b| b.frm.button(name: 'methodToCall.generateAllPeriods').click }
  action(:calculate_all_periods) { |b| b.frm.button(name: 'methodToCall.questionCalculateAllPeriods').click }
  action(:default_periods) { |b| b.frm.button(name: 'methodToCall.defaultPeriods').click }

  # =======
  private
  # =======

  element(:bo_table) { |b| b.frm.div(id: 'tab-BudgetOverview-div').table }

end