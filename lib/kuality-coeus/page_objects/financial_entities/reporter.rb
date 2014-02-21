class Reporter < FinancialEntities

  tab_buttons

  element(:contact_info) { |b| b.frm.table(id: 'response-table').table(class: 'tab') }
  element(:full_name) { |p| p.contact_info[0][1].text }

  element(:unit_number) { |b| b.frm.text_field(id: 'financialEntityHelper.newFinancialEntityReporterUnit.unitNumber') }
  element(:lead_unit) { |b| b.frm.checkbox(name: 'financialEntityHelper.newFinancialEntityReporterUnit.leadUnitFlag') }
  action(:add_unit) { |b| b.frm.button(name: 'methodToCall.addFinancialEntityReporterUnit.line').click; b.loading }

end