class NewFinancialEntity < FinancialEntities

  financial_entities_tabs

  action(:request_new_entity) { |b| b.frm.link(title: "Request New Entity").click }

end