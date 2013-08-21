class AwardContacts < KCAwards

  award_header_elements

  element(:kp_employee_user_name) { |b| b.frm.text_field(name: 'projectPersonnelBean.newProjectPerson.person.fullName') }
  element(:kp_non_employee_id) { |b| b.frm.text_field(name: 'projectPersonnelBean.newProjectPerson.rolodex.fullName') }
  element(:kp_project_role) { |b| b.frm.select(name: 'projectPersonnelBean.contactRoleCode') }
  element(:key_person_role) { |b| b.frm.text_field(name: 'projectPersonnelBean.newAwardContact.keyPersonRole') }
  action(:add_key_person) { |b| b.frm.button(name: 'methodToCall.addProjectPerson').click; b.loading }
  
  element(:unit_employee_user_name) { |b| b.frm.text_field(name: 'unitContactsBean.newAwardContact.fullName') }
  element(:unit_project_role) { |b| b.frm.select(name: 'unitContactsBean.unitContact.unitAdministratorTypeCode') }
  action(:add_unit_contact) { |b| b.frm.button(name: 'unitContactsBean.unitContact.unitAdministratorTypeCode').click; b.loading }

  element(:sponsor_non_employee_id) { |b| b.frm.text_field(name: 'sponsorContactsBean.newAwardContact.rolodex.fullName') }
  element(:sponsor_project_role){ |b| b.frm.select(name: 'sponsorContactsBean.contactRoleCode') }
  action(:add_sponsor_contact) { |b| b.frm.button(name: 'methodToCall.addSponsorContact').click; b.loading }

end