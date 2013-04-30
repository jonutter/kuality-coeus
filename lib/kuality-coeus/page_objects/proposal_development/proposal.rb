class Proposal < ProposalDevelopmentDocument

  proposal_header_elements
  error_messages

  value(:feedback) { |b| b.frm.div(class: 'left-errmsg').text }

  # Required fields
  #element(:description) { |b| b.frm.text_field(id: 'document.documentHeader.documentDescription') }
  element(:sponsor_code) { |b| b.frm.text_field(id: 'document.developmentProposalList[0].sponsorCode') }
  action(:find_sponsor_code) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Sponsor!!).(((sponsorCode:document.developmentProposalList[0].sponsorCode,sponsorName:document.developmentProposalList[0].sponsor.sponsorName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorRequiredFieldsforSavingDocument').click }
  element(:proposal_type) { |b| b.frm.select(id: 'document.developmentProposalList[0].proposalTypeCode') }
  element(:lead_unit) { |b| b.frm.select(id: 'document.developmentProposalList[0].ownedByUnitNumber') }
  value(:lead_unit_ro) { |b| b.frm.div(class: 'tab-container').table[2][1].text }
  element(:project_start_date) { |b| b.frm.text_field(id: 'document.developmentProposalList[0].requestedStartDateInitial') }
  element(:project_end_date) { |b| b.frm.text_field(id: 'document.developmentProposalList[0].requestedEndDateInitial') }
  element(:activity_type) { |b| b.frm.select(id: 'document.developmentProposalList[0].activityTypeCode') }
  element(:project_title) { |b| b.frm.text_field(id: 'document.developmentProposalList[0].title') }

  # Institutional fields

  # Sponsor and Program Information
  element(:sponsor_deadline_date) { |b| b.frm.text_field(id: 'document.developmentProposalList[0].deadlineDate') }

  # Applicant Organization

  # Performing Organization

  # Performance Site Locations

  # Other Organizations

  # Delivery Info

  # Keywords

  # When the proposal is deleted...
  value(:error_message) { |b| b.frm.table(class: 'container2').row[1].text }

  # Overview tab error divs
  element(:overview_tab_errors) { |b| b.frm.div(index: 0, class: 'left-errmsg-tab').div(index: 0).divs(style: 'display:list-item;margin-left:20px;') }

  # Required Fields tab error divs
  element(:required_fields_errors) { |b| b.frm.div(index: 1, class: 'left-errmsg-tab').div(index: 0).divs(style: 'display:list-item;margin-left:20px;') }

  element(:error_summary) { |b| b.frm.div(class: 'error') }

end