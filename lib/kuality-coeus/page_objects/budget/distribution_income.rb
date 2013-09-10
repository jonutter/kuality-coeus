class DistributionAndIncome < BudgetDocument

  element(:add_cost_share_period) { |b| b.frm.text_field(name: 'newBudgetCostShare.projectPeriod') }
  element(:add_cost_share_percentage) { |b| b.frm.text_field(name: 'newBudgetCostShare.sharePercentage') }
  element(:add_cost_share_source_account) { |b| b.frm.text_field(name: 'newBudgetCostShare.sourceAccount') }
  element(:add_cost_share_amount) { |b| b.frm.text_field(name: 'newBudgetCostShare.shareAmount') }
  action(:add_cost_share) { |b| b.frm.button(name: 'methodToCall.addCostShare').click; b.loading }

  action(:cost_sharing_project_period) { |index, b| b.frm.text_field(name: "document.budget.budgetCostShare[#{index}].projectPeriod") }
  action(:cost_sharing_percentage) { |index, b| b.frm.text_field(name: "document.budget.budgetCostShare[#{index}].sharePercentage") }
  action(:cost_sharing_source_account) { |index, b| b.frm.text_field(name: "document.budget.budgetCostShare[#{index}].sourceAccount") }
  action(:cost_sharing_amount) { |index, b| b.frm.text_field(name: "document.budget.budgetCostShare[#{index}].shareAmount") }

end