class NonPersonnel < BudgetDocument

  select_budget_period

  # Participant Support
  element(:number_of_participants) { |b| b.frm.text_field(name: 'document.budget.budgetPeriods[0].numberOfParticipants') }
  element(:new_participant_object_code) { |b| b.frm.select(name: 'newBudgetLineItems[2].costElement') }
  element(:new_participant_base_cost) { |b| b.frm.text_field(name: 'newBudgetLineItems[2].lineItemCost') }
  alias_method :new_participant_change_amount, :new_participant_base_cost
  action(:add_participant_support) { |b| b.frm.button(name: 'methodToCall.addBudgetLineItem.budgetCategoryTypeCodeS.catTypeIndex2.anchorParticipantSupport').click; b.loading }

end