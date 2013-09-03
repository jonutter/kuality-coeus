class DistributionAndIncome < BudgetDocument

  element(:add_cost_share_period) { |b| b.frm.text_field(name: 'newBudgetCostShare.projectPeriod') }
  element(:add_cost_share_percentage) { |b| b.frm.text_field(name: 'newBudgetCostShare.sharePercentage') }
  element(:add_cost_share_source_account) { |b| b.frm.text_field(name: 'newBudgetCostShare.sourceAccount') }
  element(:add_cost_share_amount) { |b| b.frm.text_field(name: 'newBudgetCostShare.shareAmount') }
  action(:add_cost_share) { |b| b.frm.button(name: 'methodToCall.addCostShare').click; b.loading }

  action(:cost_sharing_project_period) { |item, b| b.cost_sharing_table.row(text: /^#{item}/).text_field(title: 'Project Period') }
  action(:cost_sharing_percentage) { |item, b| b.cost_sharing_table.row(text: /^#{item}/).text_field(title: 'Percentage') }
  action(:cost_sharing_source_account) { |item, b| b.cost_sharing_table.row(text: /^#{item}/).text_field(title: 'Source Account') }
  action(:cost_sharing_amount) { |item, b| b.cost_sharing_table.row(text: /^#{item}/).text_field(title: 'Amount') }

  # ============
  private
  # ============
  
  element(:cost_sharing_table) { |b| b.frm.table(id: 'budget-cost-sharing-table') }


end