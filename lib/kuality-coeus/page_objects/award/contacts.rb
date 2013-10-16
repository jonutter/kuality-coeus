class AwardContacts < KCAwards

  award_header_elements

  expected_element :close_button

  # Key Personnel
  action(:kp_employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:projectPersonnelBean.personId))).((`projectPersonnelBean.newProjectPerson.person.fullName:lastName`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorKeyPersonnelandCreditSplit').click }
  element(:kp_employee_user_name) { |b| b.frm.text_field(name: 'projectPersonnelBean.newProjectPerson.person.fullName') }
  value(:kp_employee_full_name) { |b| b.frm.div(id: 'per.fullName.div').text }
  element(:kp_non_employee_id) { |b| b.frm.text_field(name: 'projectPersonnelBean.newProjectPerson.rolodex.fullName') }
  element(:kp_project_role) { |b| b.frm.select(name: 'projectPersonnelBean.contactRoleCode') }
  element(:key_person_role) { |b| b.frm.text_field(name: 'projectPersonnelBean.newAwardContact.keyPersonRole') }
  action(:add_key_person) { |b| b.frm.button(name: 'methodToCall.addProjectPerson').click; b.loading }

  # Person Details

  # Unit Details
  action(:add_lead_unit) { |name, b| b.person_units(name).checkbox(title: 'Lead Unit').set }
  action(:add_unit_number) { |name, b| b.person_units(name).text_field(title: 'Unit Number') }
  action(:add_unit) { |name, b| b.person_units(name).button(title: 'Add Contact').click }
  action(:units) { |name, b| un=[]; b.person_units(name).to_a.each{ |row| un << row[3].strip }; 2.times{un.delete_at(0)}; un }
  action(:lead_unit_radio) { |name, unit, b| b.person_unit_row(name, unit).radio(name: 'selectedLeadUnit') }
  action(:delete_unit) { |name, unit, b| b.person_unit_row(name, unit).button(name: /methodToCall.deleteProjectPersonUnit/).click }

  # This button is only present in the context of a Key Person...
  action(:add_unit_details) { |name, p| p.person_units(name).button(title: 'Add Unit Details').click }


  # Combined Credit Split

  # Unit Contacts
  element(:unit_employee_user_name) { |b| b.frm.text_field(name: 'unitContactsBean.newAwardContact.fullName') }
  element(:unit_project_role) { |b| b.frm.select(name: 'unitContactsBean.unitContact.unitAdministratorTypeCode') }
  action(:add_unit_contact) { |b| b.frm.button(name: 'unitContactsBean.unitContact.unitAdministratorTypeCode').click; b.loading }

  # Sponsor Contacts
  element(:sponsor_non_employee_id) { |b| b.frm.text_field(name: 'sponsorContactsBean.newAwardContact.rolodex.fullName') }
  element(:sponsor_project_role){ |b| b.frm.select(name: 'sponsorContactsBean.contactRoleCode') }
  action(:add_sponsor_contact) { |b| b.frm.button(name: 'methodToCall.addSponsorContact').click; b.loading }

  # Close button element (used to force waiting for page load)
  element(:close_button) { |b| b.frm.button(title: 'close') }

  # ===========
  private
  # ===========
  
  action(:target_key_person_div) { |name, b| b.frm.div(id: "tab-#{nsp(name)}:UnitDetails-div") }
  action(:person_units) { |name, b| b.target_key_person_div(name).table(summary: 'Project Personnel Units') }
  action(:person_unit_row) { |name, unit, b| b.person_units(name).row(text: /#{unit}/) }

end