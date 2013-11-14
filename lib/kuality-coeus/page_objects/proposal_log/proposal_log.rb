class ProposalLog < BasePage

  description_field
  document_header_elements
  global_buttons
  tab_buttons
  route_log
  error_messages
  
  value(:proposal_number) { |b| b.frm.span(id: 'document.newMaintainableObject.proposalNumber.div').text }
  element(:proposal_log_type) { |b| b.frm.select(id: 'document.newMaintainableObject.proposalLogTypeCode') }
  value(:proposal_log_status) { |b| b.frm.span(id: 'document.newMaintainableObject.logStatus.div').text }
  element(:proposal_type) { |b| b.frm.select(id: 'document.newMaintainableObject.proposalTypeCode') }
  element(:title) { |b| b.frm.text_field(id: 'document.newMaintainableObject.title') }
  element(:lead_unit) { |b| b.frm.text_field(id: 'document.newMaintainableObject.leadUnit') }
  element(:sponsor) { |b| b.frm.text_field(name: 'document.newMaintainableObject.sponsorCode') }
  action(:find_sponsor_code) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Sponsor!!).(((sponsorCode:document.newMaintainableObject.sponsorCode,))).((`document.newMaintainableObject.sponsorCode:sponsorCode,`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor4').click }
  element(:principal_investigator_employee) { |b| b.frm.text_field(id: 'document.newMaintainableObject.person.userName') }
  action(:employee_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.rice.kim.api.identity.Person!!).((())).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor4').click }
  element(:principal_investigator_non_employee) { |b| b.frm.text_field(id: 'document.newMaintainableObject.rolodexId') }
  value(:pi_full_name) { |b| b.frm.span(id: 'document.newMaintainableObject.person.fullName.div').text.strip.gsub('  ', ' ') }

  #Table for temporary proposal logs to be merged
  element(:temporary_proposal_log_table) { |b| b.frm.table(id: 'proposalLogMergeList') }
  action(:proposal_number_row) { |number, b| b.temporary_proposal_log_table.row(text: /#{number}/) }
  action(:merge_proposal_log) { |number, b| b.proposal_number_row(number).button(class: 'mergeLink').click }

end