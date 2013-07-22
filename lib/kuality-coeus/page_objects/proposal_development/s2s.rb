class S2S < ProposalDevelopmentDocument

  proposal_header_elements

  element(:s2s_header) { |b| b.frm.h2(text: 'S2S') }
  action(:s2s_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.s2s.bo.S2sOpportunity!!).(((opportunityId:newS2sOpportunity.opportunityId,cfdaNumber:newS2sOpportunity.cfdaNumber,opportunityTitle:newS2sOpportunity.opportunityTitle,s2sSubmissionTypeCode:newS2sOpportunity.s2sSubmissionTypeCode,revisionCode:newS2sOpportunity.revisionCode,competetionId:newS2sOpportunity.competetionId,openingDate:newS2sOpportunity.openingDate,closingDate:newS2sOpportunity.closingDate,instructionUrl:newS2sOpportunity.instructionUrl,schemaUrl:newS2sOpportunity.schemaUrl,providerCode:newS2sOpportunity.providerCode))).((`document.developmentProposalList[0].programAnnouncementNumber:opportunityId,document.developmentProposalList[0].cfdaNumber:cfdaNumber,document.developmentProposalList[0].s2sOpportunity.providerCode:providerCode`)).((<>)).(([])).((**)).((^^)).((&yes&)).((//)).((~no~)).(::::;;::::).anchor').click }

  # Submission Details
  element(:submission_details_table) { |b| b.frm.div(id: 'tab-OpportunitySearch:SubmissionDetails-div').table }
  element(:refresh_submission_details_button) { |b| b.frm.button(alt: 'Refresh Submission Details') }
  action(:refresh_submission_details) { |b| b.refresh_submission_details_button.click; b.loading }
  value(:received_date) { |b| b.submission_details_table[0][1].text }
  value(:last_modified_date) { |b| b.submission_details_table[0][3].text }
  value(:submission_status) { |b| b.submission_details_table[1][1].text }
  value(:s2s_tracking_id) { |b| b.submission_details_table[2][1].text }
  value(:agency_tracking_id) { |b| b.submission_details_table[3][1].text }
  value(:comments) { |b| b.submission_details_table[4][1].text }

end