class DistributionAndIncome < BudgetDocument

  element(:add_cost_share_period) { |b| b.frm.text_field(name: 'newBudgetCostShare.projectPeriod') }
  element(:add_cost_share_percentage) { |b| b.frm.text_field(name: 'newBudgetCostShare.sharePercentage') }
  element(:add_cost_share_source_account) { |b| b.frm.text_field(name: 'newBudgetCostShare.sourceAccount') }
  element(:add_cost_share_amount) { |b| b.frm.text_field(name: 'newBudgetCostShare.shareAmount') }
  action(:add_cost_share) { |b| b.frm.button(name: 'methodToCall.addCostShare').click; b.loading }

  p_element(:cost_sharing_project_period) { |index, b| b.frm.text_field(name: "document.budget.budgetCostShare[#{index}].projectPeriod") }
  p_element(:cost_sharing_percentage) { |index, b| b.frm.text_field(name: "document.budget.budgetCostShare[#{index}].sharePercentage") }
  p_element(:cost_sharing_source_account) { |index, b| b.frm.text_field(name: "document.budget.budgetCostShare[#{index}].sourceAccount") }
  p_element(:cost_sharing_amount) { |index, b| b.frm.text_field(name: "document.budget.budgetCostShare[#{index}].shareAmount") }

  element(:add_fa_fiscal_year) { |b| b.frm.text_field(name: 'newBudgetUnrecoveredFandA.fiscalYear') }
  element(:add_fa_applicable_rate) { |b| b.frm.text_field(name: 'newBudgetUnrecoveredFandA.applicableRate') }
  element(:add_fa_campus) { |b| b.frm.select(name: 'newBudgetUnrecoveredFandA.onCampusFlag') }
  element(:add_fa_source_account) { |b| b.frm.text_field(name: 'newBudgetUnrecoveredFandA.sourceAccount') }
  element(:add_fa_amount) { |b| b.frm.text_field(name: 'newBudgetUnrecoveredFandA.amount') }
  action(:add_fa) { |b| b.frm.button(name: 'methodToCall.addUnrecoveredFandA').click; b.loading }

  element(:existing_fna_rows) { |b| b.unrecovered_fna_table.rows[2..-3] }
  element(:unrecovered_fna_table) { |b| b.frm.table(id: 'budget-unrecovered-fna-table') }

  p_element(:fiscal_year) { |index, b| b.frm.text_field(name: "document.budget.budgetUnrecoveredFandA[#{index}].fiscalYear") }
  p_element(:applicable_rate) { |index, b| b.frm.text_field(name: "document.budgets[0].budgetUnrecoveredFandAs[#{index}].applicableRate") }
  p_element(:campus) { |index, b| b.frm.select(name: "document.budget.budgetUnrecoveredFandA[#{index}].onCampusFlag") }
  p_element(:fa_source_account) { |index, b| b.frm.text_field(name: "document.budget.budgetUnrecoveredFandA[#{index}].sourceAccount") }
  p_element(:fa_amount) { |index, b| b.frm.text_field(name: "document.budget.budgetUnrecoveredFandA[#{index}].amount") }

end