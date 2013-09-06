class BudgetColumnToAlter < BasePage

  description_field
  tab_buttons
  global_buttons
  
  element(:name) { |b| b.frm.select(name: 'document.newMaintainableObject.columnName') }
  element(:has_lookup) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.hasLookup') }
  element(:lookup_argument) { |b| b.frm.select(name: 'document.newMaintainableObject.lookupClass') }
  element(:lookup_return) { |b| b.frm.select(name: 'document.newMaintainableObject.lookupReturn') }

end