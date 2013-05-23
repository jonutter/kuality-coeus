class ModularBudget < BudgetDocument

  element(:budget_period) { |b| b.frm.select(name: 'modularSelectedPeriod') }
  action(:update_view) { |b| b.frm.button(name: 'methodToCall.updateView').click; b.loading }

  element(:direct_cost_less_cons_fa) { |b| b.frm.text_field(title: 'Direct Cost Less Consortium FNA') }
  element(:consortium_f_and_a) { |b| b.frm.text_field(title: 'Consortium FNA') }
  
  element(:f_and_a_rate_type) { |b| b.frm.select(name: 'newBudgetModularIdc.description') }
  element(:f_and_a_rate) { |b| b.frm.text_field(name: 'newBudgetModularIdc.idcRate') }
  element(:f_and_a_base) { |b| b.frm.text_field(name: 'newBudgetModularIdc.idcBase') }
  action(:add_f_and_a) { |b| b.frm.button(name: 'methodToCall.add').click; b.loading }

  action(:sync) { |b| b.frm.button(name: 'methodToCall.sync').click; b.loading }

end