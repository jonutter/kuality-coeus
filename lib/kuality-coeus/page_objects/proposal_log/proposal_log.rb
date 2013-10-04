class ProposalLog < BasePage

  description_field
  document_header_elements
  global_buttons
  tab_buttons
  route_log
  error_messages
  
  element(:proposal_log_type) { |b| b.frm.select(id: 'document.newMaintainableObject.proposalLogTypeCode') }
  element(:proposal_type) { |b| b.frm.select(id: 'document.newMaintainableObject.proposalTypeCode') }
  element(:title) { |b| b.frm.text_field(id: 'document.newMaintainableObject.title') }
  element(:lead_unit) { |b| b.frm.text_field(id: 'document.newMaintainableObject.leadUnit') }
  element(:principal_investigator_employee) { |b| b.frm.text_field(id: 'document.newMaintainableObject.person.userName') }
  element(:principal_investigator_non_employee) { |b| b.frm.text_field(id: 'document.newMaintainableObject.rolodexId') }


end