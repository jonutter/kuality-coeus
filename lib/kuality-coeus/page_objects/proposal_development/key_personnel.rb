class KeyPersonnel < ProposalDevelopmentDocument

  proposal_header_elements

  action(:employee_search) { |b| b.frm.button(name: "methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:newPersonId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor").click }
  action(:non_employee_search) { |b| b.frm.button(name: "methodToCall.performLookup.(!!org.kuali.kra.bo.NonOrganizationalRolodex!!).(((rolodexId:newRolodexId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor").click }
  element(:proposal_role) { |b| b.frm.select(id: "newProposalPerson.proposalPersonRoleId") }
  element(:key_person_role) { |b| b.frm.text_field(id: "newProposalPerson.projectRole") }
  action(:add_person) { |b| b.frm.button(name: "methodToCall.insertProposalPerson").click }
  action(:clear) { |b| b.frm.button(name: "methodToCall.clearProposalPerson").click }

  action(:select_unit) { |b| b.frm.button(name: "methodToCall.performLookup.(!!org.kuali.kra.bo.Unit!!).(((unitNumber:newProposalPersonUnit[0].unitNumber,unitName:newProposalPersonUnit[0].unitName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor").click }
  element(:unit_number) { |b| b.frm.text_field(id: /unitNumber/) }

  value()
end