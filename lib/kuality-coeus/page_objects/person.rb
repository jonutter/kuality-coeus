class Person < BasePage

  document_header_elements
  global_buttons
  tab_buttons

  element(:description) { |b| b.frm.text_field(id: 'document.documentHeader.documentDescription') }
  element(:principal_name) { |b| b.frm.text_field(id: 'document.principalName') }
  element(:affiliation_type) { |b| b.frm.select(id: 'newAffln.affiliationTypeCode') }
  element(:campus_code) { |b| b.frm.select(id: 'newAffln.campusCode') }
  element(:affiliation_default) { |b| b.frm.checkbox(id: 'newAffln.dflt') }
  element(:first_name) { |b| b.frm.text_field(id: 'newName.firstName') }
  element(:last_name) { |b| b.frm.text_field(id: 'newName.lastName') }
  element(:name_default) { |b| b.frm.checkbox(id: 'newName.dflt') }
  action(:add_affiliation) { |b| b.frm.button(name: 'methodToCall.addAffln.anchor').click }
  element(:employee_id) { |b| b.frm.text_field(id: 'document.affiliations[0].newEmpInfo.employeeId') }
  element(:employee_status) { |b| b.frm.select(id: 'document.affiliations[0].newEmpInfo.employmentStatusCode') }
  element(:employee_type) { |b| b.frm.select(id: 'document.affiliations[0].newEmpInfo.employmentTypeCode') }
  element(:primary_employment) { |b| b.frm.checkbox(id: 'document.affiliations[0].newEmpInfo.primary') }
  element(:base_salary) { |b| b.frm.text_field(id: 'document.affiliations[0].newEmpInfo.baseSalaryAmount') }
  action(:add_employment_information) { |b| b.frm.button(name: 'methodToCall.addEmpInfo.line0.anchor').click; b.loading }
  action(:add_name) { |b| b.frm.button(name: 'methodToCall.addName.anchor').click }
  element(:role_id) { |b| b.frm.text_field(id: 'newRole.roleId') }
  action(:add_role) { |b| b.frm.button(name: 'methodToCall.addRole.anchor').click; b.loading }
  element(:group_id) { |b| b.frm.text_field(id: 'newGroup.groupId') }
  action(:add_group) { |b| b.frm.button(name: 'methodToCall.addGroup.anchor').click; b.loading }

  action(:unit_number) { |role, b| b.frm.div(id: 'tab-Roles-div').table(index: 0).rows[b.role_row(role)+1].text_field(title: '* Unit Number') }
  action(:add_role_qualifier) { |role, b| b.frm.div(id: 'tab-Roles-div').table(index: 0).rows[b.role_row(role)+1].button(name: /methodToCall.addRoleQualifier.line\d+.anchor/).click; b.loading }

  # =========
  private
  # =========

  action(:role_row) { |role, b| b.frm.div(id: 'tab-Roles-div').table(index: 0).rows.find_index{ |row| row.text.include?(role.to_s) } }

end