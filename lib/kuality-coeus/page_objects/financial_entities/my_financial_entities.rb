class MyFinancialEntities < FinancialEntities

  financial_entities_tabs

  action(:edit) { |name, b| b.fe_row(name).button(title: "Edit").click }

  private

  action(:fe_row) { |name, b| b.td(text: name).parent }

end