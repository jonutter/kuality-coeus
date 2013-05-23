class Rates < BudgetDocument

  glbl 'Sync All Rates', 'Reset All Rates'

  # ========
  private
  # ========
  
  element(:research_fa_table) { |b| b.frm.table(id: 'Research F & A') }
  element(:fringe_benefits_table) { |b| b.frm.table(id: 'Fringe Benefits') }
  element(:inflation_table) { |b| b.frm.table(id: 'Inflation') }
  element(:vacation_table) { |b| b.frm.table(id: 'Vacation') }
  element(:other_table) { |b| b.frm.table(id: 'Other') }
  
end