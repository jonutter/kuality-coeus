class BudgetActions < BudgetDocument

  action(:turn_on_validation) { |b| b.frm.button(name: 'methodToCall.activate').click; b.loading }
  action(:consolidate_expense_justifications) { |b| b.frm.button(name: 'methodToCall.consolidateExpenseJustifications').click }
  element(:justification_text) { |b| b.frm.text_field(name: 'budgetJustification.justificationText') }

  # Subaward Budget
  # adding...
  element(:add_organization_id) { |b| b.frm.text_field(name: 'newSubAward.organizationId') }
  element(:add_comments) { |b| b.frm.text_field(name: 'newSubAward.comments') }
  element(:add_file_name) { |b| b.frm.file_field(name: 'newSubAward.newSubAwardFile') }
  action(:add_subaward_budget) { |b| b.frm.button(name: 'methodToCall.addSubAward.anchorSubawardBudget').click; b.loading }
  action(:look_up_organization) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Organization!!).(((organizationId:newSubAward.organizationId,organizationName:newSubAward.organizationName))).((`newSubAward.organizationId:organizationId`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorSubawardBudget').click }
  value(:organization_name) { |b| b.frm.div(id: 'newSubAward.organizationName.div').text }

  # editing...
  action(:organization_id) { |name, b| b.frm.text_field(name: "document.budget.budgetSubAwards[#{b.target_subaward(name)}].organizationId") }
  action(:show_attachment_details) { |name, b| b.frm.button(title: 'open Attachment Details', index: b.target_subaward(name).to_i).click }
  action(:show_details) { |name, b| b.frm.button(title: 'open Details', index: b.target_subaward(name).to_i).click }
  action(:direct_cost) { |name, b| b.frm.text_field(name: "document.budget.budgetSubAwards[#{b.target_subaward(name)}].budgetSubAwardPeriodDetails[0].directCost") }
  action(:f_and_a_cost) { |name, b| b.frm.text_field(name: "document.budget.budgetSubAwards[#{b.target_subaward(name)}].budgetSubAwardPeriodDetails[0].indirectCost") }
  action(:cost_sharing) { |name, b| b.frm.text_field(name: "document.budget.budgetSubAwards[#{b.target_subaward(name)}].budgetSubAwardPeriodDetails[0].costShare") }
  action(:total_cost) { |name, b| b.frm.span(class: 'totalCost', index: b.target_subaward(name).to_i).text }
  
  # ========
  private
  # ========

  action(:target_subaward) { |item, b| b.frm.div(text: item).id[/(?<=\[)\d+/] }

end