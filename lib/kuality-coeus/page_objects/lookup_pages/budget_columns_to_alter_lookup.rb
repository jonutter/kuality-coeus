class BudgetColumnsToAlterLookup < Lookups

  element(:column_name) { |b| b.frm.select(name: 'columnName') }

end