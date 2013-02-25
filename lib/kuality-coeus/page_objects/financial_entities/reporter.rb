class Reporter < FinancialEntities

  financial_entities_tabs

  element(:contact_info) { |b| b.frm.table(id: 'response-table').table(class: 'tab') }
  element(:full_name) { |p| p.contact_info[0][1].text }

  element(:unit_number) { |b| b.frm.text_field(id: 'financialEntityHelper.newFinancialEntityReporterUnit.unitNumber') }


end