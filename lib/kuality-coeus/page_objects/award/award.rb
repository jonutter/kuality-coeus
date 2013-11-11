class Award < KCAwards

  award_header_elements
  description_field

  element(:institutional_proposal_number) { |b| b.frm.text_field(name: 'fundingProposalBean.newFundingProposal.proposalNumber') }
  element(:proposal_merge_type) { |b| b.frm.select(name: 'fundingProposalBean.mergeTypeCode') }
  action(:add_proposal) { |b| b.frm.button(name: 'methodToCall.addFundingProposal.anchorFundingProposals').click; b.loading }
  element(:transaction_type) { |b| b.frm.select(name: 'document.awardList[0].awardTransactionTypeCode') }
  value(:award_id) { |b| b.frm.div(id: 'tab-DetailsDates:Institution-div').table[0][1].text }
  element(:award_status) { |b| b.frm.select(name: 'document.awardList[0].statusCode') }
  element(:lead_unit_id) { |b| b.frm.text_field(name: 'document.awardList[0].unitNumber') }
  value(:lead_unit_ro) { |b| b.frm.div(id: 'tab-DetailsDates:Institution-div').table[0][3].text }
  action(:lookup_lead_unit) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Unit!!).(((unitNumber:document.awardList[0].unitNumber))).((`document.awardList[0].unitNumber:unitNumber`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorDetailsDates').click }
  element(:activity_type) { |b| b.frm.select(name: 'document.awardList[0].activityTypeCode') }
  element(:award_type) { |b| b.frm.select(name: 'document.awardList[0].awardTypeCode') }
  element(:award_title) { |b| b.frm.text_field(name: 'document.awardList[0].title') }
  element(:sponsor_id) { |b| b.frm.text_field(name: 'document.awardList[0].sponsorCode') }
  action(:lookup_sponsor) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Sponsor!!).(((sponsorCode:document.awardList[0].sponsorCode,sponsorName:document.awardList[0].sponsor.sponsorName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorDetailsDates').click }
  element(:project_start_date) { |b| b.frm.text_field(name: /awardEffectiveDate/) }
  element(:project_end_date) { |b| b.frm.text_field(name: /finalExpirationDate/) }
  element(:obligation_start_date) { |b| b.frm.text_field(name: /currentFundEffectiveDate/) }
  element(:obligation_end_date) { |b| b.frm.text_field(name: /obligationExpirationDate/) }
  element(:anticipated_amount) { |b| b.frm.text_field(name: /anticipatedTotalAmount/) }
  element(:obligated_amount) { |b| b.frm.text_field(name: /amountObligatedToDate/) }
  
  element(:add_organization_name) { |b| b.frm.text_field(name: 'approvedSubawardFormHelper.newAwardApprovedSubaward.organizationName') }
  action(:search_organization) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Organization!!).(((organizationName:approvedSubawardFormHelper.newAwardApprovedSubaward.organizationName,organizationId:approvedSubawardFormHelper.newAwardApprovedSubaward.organizationId))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorSubawards').click }
  element(:add_subaward_amount) { |b| b.frm.text_field(name: 'approvedSubawardFormHelper.newAwardApprovedSubaward.amount') }
  action(:add_subaward) { |b| b.frm.button(name: 'methodToCall.addApprovedSubaward.anchorSubawards').click }
  element(:approved_subaward_table) { |b| b.frm.table(summary: 'Approved Subaward') }

end