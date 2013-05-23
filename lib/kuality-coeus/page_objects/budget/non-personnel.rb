class NonPersonnel < BudgetDocument

  select_budget_period

  element(:new_participant_object_code) { |b| b.frm.select(name: 'newBudgetLineItems[2].costElement') }
  element(:new_participant_base_cost) { |b| b.frm.text_field(name: 'newBudgetLineItems[2].lineItemCost') }
  action(:add_participant_support) { |b| b.frm.button(name: 'methodToCall.addBudgetLineItem.budgetCategoryTypeCodeS.catTypeIndex2.anchorParticipantSupport').click; b.loading }



end