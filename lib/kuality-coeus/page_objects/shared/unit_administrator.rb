class UnitAdministrator < BasePage

  document_header_elements
  description_field
  global_buttons
  tab_buttons
  route_log

  element(:unit_administrator_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.unitAdministratorTypeCode') }
  element(:kc_person) { |b| b.frm.text_field(name: 'document.newMaintainableObject.person.userName') }
  element(:unit_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.unitNumber') }
  
end