class Parameters < BasePage

  budget_header_elements

  #Budget Overview
  element(:total_direct_cost_limit) { |b| b.frm.text_field(name: "document.budget.totalDirectCostLimit").click }
  element(:on_off_campus) { |b| b.frm.select(name: "document.budget.onOffCampusFlag").click }
  element(:comments) { |b| b.frm.text_field(name: "document.budget.comments").click }
  action(:final) { |b| b.frm.radio(name: "document.budget.finalVersionFlag").click }
  action(:modular_budget) { |b| b.frm.radio(name: "document.budget.modularBudgetFlag").click }
  element(:residual_funds) { |b| b.frm.text_field(name: "document.budget.residualFunds").click }
  element(:total_cost_limit) { |b| b.frm.text_field(name: "document.budget.totalCostLimit").click }
  element(:unrecovered_fa_rate_type) { |b| b.frm.select(name: "document.budget.urRateClassCode").click }
  element(:fa_rate_type) { |b| b.frm.select(name: "document.budget.ohRateClassCode").click }
  element(:submit_cost_sharing) { |b| b.frm.radio(name:"document.budget.submitCostSharingFlag").click }

  #Adding new budget period
  element(:period_start_date) { |b| b.frm.text_field(name: "newBudgetPeriod.startDate").click }
  element(:period_end_date) { |b| b.frm.text_field(name: "newBudgetPeriod.endDate").click }
  element(:total_sponsor_cost) { |b| b.frm.text_field(name: "newBudgetPeriod.totalCost").click }
  element(:direct_cost) { |b| b.frm.text_field(name: "newBudgetPeriod.totalDirectCost").click }
  element(:fa_cost) { |b| b.frm.text_field(name: "newBudgetPeriod.totalIndirectCost").click }
  element(:unrecovered_fa_cost) { |b| b.frm.text_field(name: "newBudgetPeriod.underrecoveryAmount").click }
  element(:cost_sharing) { |b| b.frm.text_field(name: "newBudgetPeriod.costSharingAmount").click }
  element(:cost_limit) { |b| b.frm.text_field(name: "newBudgetPeriod.totalCostLimit").click }
  element(:direct_cost_limit) { |b| b.frm.text_field(name: "newBudgetPeriod.directCostLimit").click }
  action(:add_budget_period) { |b| b.frm.button(name:"methodToCall.recalculateBudgetPeriod.anchorBudgetPeriodsTotals").click }

  action(:recalculate_budget_periods) { |b| b.frm.button(name: "methodToCall.recalculateBudgetPeriod.anchorBudgetPeriodsTotals").click }

  action(:generate_all_periods) { |b| b.frm.button(name: "methodToCall.generateAllPeriods").click }
  action(:calculate_all_periods) { |b| b.frm.button(name: "methodToCall.questionCalculateAllPeriods").click }
  action(:default_periods) { |b| b.frm.button(name: "methodToCall.defaultPeriods").click }
end