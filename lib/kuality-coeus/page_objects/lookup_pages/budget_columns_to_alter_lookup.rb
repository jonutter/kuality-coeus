class BudgetColumnsToAlterLookup < Lookups

  url_info 'Budget%20Editable%20Columns','kra.proposaldevelopment.budget.bo.BudgetColumnsToAlter'

  element(:column_name) { |b| b.frm.select(name: 'columnName') }
  element(:lookup_argument) { |b| b.frm.select(name: 'lookupClass') }
  element(:lookup_return) { |b| b.frm.select(name: 'lookupReturn') }

  # Because the Lookup Argument select list is 450 items long, we have this
  # Nokogiri code here, which returns the list much faster than Watir does.
  # This enables, for example, a faster randomized item selection from the list...
  value(:lookup_argument_list) { |b| b.noko.select(name: 'lookupClass').options.map {|opt| opt.text }[1..-1] }

end