class BudgetActions < BudgetDocument

  action(:turn_on_validation) { |b| b.frm.button(name: 'methodToCall.activate').click; b.loading }
  action(:consolidate_expense_justifications) { |b| b.frm.button(name: 'methodToCall.consolidateExpenseJustifications').click }
  element(:justification_text) { |b| b.frm.text_field(name: 'budgetJustification.justificationText') }
  
end