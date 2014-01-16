class BudgetColumnToAlter < BasePage

  description_field
  tab_buttons
  global_buttons
  
  element(:name) { |b| b.frm.select(name: 'document.newMaintainableObject.columnName') }
  element(:has_lookup) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.hasLookup') }
  element(:lookup_argument) { |b| b.frm.select(name: 'document.newMaintainableObject.lookupClass') }
  element(:lookup_return) { |b| b.frm.select(name: 'document.newMaintainableObject.lookupReturn') }

  # Because the Lookup Argument select list is 450 items long, we have this
  # Nokogiri code here, which returns the list much faster than Watir does.
  # This enables, for example, a faster randomized item selection from the list...
  value(:lookup_argument_list) { |b| b.noko.select(name: 'document.newMaintainableObject.lookupClass').options.map {|opt| opt.text }[1..-1] }

end