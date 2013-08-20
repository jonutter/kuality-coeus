class S2S < ProposalDevelopmentDocument

  proposal_header_elements

  element(:s2s_header) { |b| b.frm.h2(text: 'S2S') }
  action(:s2s_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.s2s.bo.S2sOpportunity!!).(((opportunityId:newS2sOpportunity.opportunityId,cfdaNumber:newS2sOpportunity.cfdaNumber,opportunityTitle:newS2sOpportunity.opportunityTitle,s2sSubmissionTypeCode:newS2sOpportunity.s2sSubmissionTypeCode,revisionCode:newS2sOpportunity.revisionCode,competetionId:newS2sOpportunity.competetionId,openingDate:newS2sOpportunity.openingDate,closingDate:newS2sOpportunity.closingDate,instructionUrl:newS2sOpportunity.instructionUrl,schemaUrl:newS2sOpportunity.schemaUrl,providerCode:newS2sOpportunity.providerCode))).((`document.developmentProposalList[0].programAnnouncementNumber:opportunityId,document.developmentProposalList[0].cfdaNumber:cfdaNumber,document.developmentProposalList[0].s2sOpportunity.providerCode:providerCode`)).((<>)).(([])).((**)).((^^)).((&yes&)).((//)).((~no~)).(::::;;::::).anchor').click }

  # Opportunity
  element(:opp_div) { |b| b.frm.div(id: 'tab-OpportunitySearch:Opportunity-div') }
  element(:submission_type) { |b| b.frm.select(name: 'document.developmentProposalList[0].s2sOpportunity.s2sSubmissionTypeCode') }
  element(:s2s_revision_type) { |b| b.frm.select(name: 'document.developmentProposalList[0].s2sOpportunity.revisionCode') }
  element(:revision_specify) { |b| b.frm.text_field(name: 'document.developmentProposalList[0].s2sOpportunity.revisionOtherDescription') }
  element(:remove_opp_button) { |b| b.frm.button(name: 'methodToCall.removeOpportunity') }
  # Read-only elements...
  value(:opportunity_title) { |b| b.opp_div.table.table[1][1].text }
  value(:cfda_number) { |b| b.opp_div.table.table[4][1].text }
  value(:competition_id) { |b| b.opp_div.table.table[5][1].text }

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

  # Forms
  element(:forms_table) { |b| b.frm.div(id: 'tab-OpportunitySearch:Forms-div').table }
  action(:include_form) { |name, b| b.forms_table.row(text: /#{name}/).checkbox(title: 'Include') }
  action(:form_names) { |b| array = []; b.forms_table.rows.each { |row| array << row[0].text }; array }
  
end