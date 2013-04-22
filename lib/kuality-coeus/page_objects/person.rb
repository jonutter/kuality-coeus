class Person < BasePage

  document_header_elements
  global_buttons
  tab_buttons

  element(:description) { |b| b.frm.text_field(id: 'document.documentHeader.documentDescription') }
  element(:principal_name) { |b| b.frm.text_field(id: 'document.principalName') }
  element(:affiliation_type) { |b| b.frm.select(id: 'newAffln.affiliationTypeCode') }
  element(:campus_code) { |b| b.frm.select(id: 'newAffln.campusCode') }
  element(:affiliation_default) { |b| b.frm.checkbox(id: 'newAffln.dflt') }
  element(:name_default) { |b| b.frm.checkbox(id: 'newName.dflt') }


end