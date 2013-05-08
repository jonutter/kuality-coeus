class BudgetVersions < ProposalDevelopmentDocument

  proposal_header_elements
  error_messages

  element(:name) { |b| b.frm.text_field(name: 'newBudgetVersionName') }
  action(:add) { |b| b.frm.button(name: 'methodToCall.addBudgetVersion').click }

  action(:version) { |budget, p| p.budgetline(budget).td(class: 'subhead', index: 2).text }
  action(:direct_cost) { |budget, p| p.budgetline(budget).td(class: 'subhead', index: 3).text }
  action(:f_and_a) { |budget, p| p.budgetline(budget).td(class: 'subhead', index: 4).text }
  action(:total) { |budget, p| p.budgetline(budget).td(class: 'subhead', index: 5).text }
  # Called "budget status" to avoid method collision...
  action(:budget_status) { |budget, p| p.budgetline(budget).select(title: 'Budget Status') }
  action(:final) { |budget, p| p.budgetline(budget).checkbox(title: 'Final?') }
  action(:open) { |budget, p| p.budgetline(budget).button(alt: 'open budget').click }
  action(:copy) { |budget, p| p.budgetline(budget).button(alt: 'copy budget').click }

  action(:residual_funds) { |budget, p| p.budget_table(budget)[0][1].text }
  action(:f_and_a_rate_type) { |budget, p| p.budget_table(budget)[0][3].text }
  action(:cost_sharing) { |budget, p| p.budget_table(budget)[1][1].text }
  action(:budget_last_updated) { |budget, p| p.budget_table(budget)[1][3].text }
  action(:unrecovered_f_and_a) { |budget, p| p.budget_table(budget)[2][1].text }
  action(:last_updated_by) { |budget, p| p.budget_table(budget)[2][3].text }
  action(:comments) { |budget, p| p.budget_table(budget)[3][1].text }

  # =======
  private
  # =======

  element(:b_v_table) { |b| b.frm.table(id: 'budget-versions-table') }
  action(:budgetline) { |budget, p| p.b_v_table.td(class: 'tab-subhead', text: budget).parent }
  action(:budget_table) { |budget, p| p.b_v_table.tbodys[p.target_index(budget)].table }

  action(:target_index) do |budget, p|
    i=p.b_v_table.tbodys.find_index { |tbody| tbody.td(class: 'tab-subhead', index: 1).text==budget }
    i+1
  end

end