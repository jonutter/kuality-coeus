class Award < KCAwards

  award_header_elements

  element(:description) { |b| b.frm.text_field(name: 'document.documentHeader.documentDescription') }
  element(:transaction_type) { |b| b.frm.select(name: 'document.awardList[0].awardTransactionTypeCode') }
  element(:award_status) { |b| b.frm.select(name: 'document.awardList[0].statusCode') }
  element(:lead_unit_id) { |b| b.frm.text_field(name: 'document.awardList[0].unitNumber') }
  element(:activity_type) { |b| b.frm.select(name: 'document.awardList[0].activityTypeCode') }
  element(:award_type) { |b| b.frm.select(name: 'document.awardList[0].awardTypeCode') }
  element(:award_title) { |b| b.frm.text_field(name: 'document.awardList[0].title') }
  element(:sponsor_id) { |b| b.frm.text_field(name: 'document.awardList[0].sponsorCode') }
  element(:project_start_date) { |b| b.frm.text_field(name: 'document.awardList[0].awardEffectiveDate') }
  element(:project_end_date) { |b| b.frm.text_field(name: 'document.awardList[0].awardAmountInfos[0].finalExpirationDate') }
  element(:obligation_start_date) { |b| b.frm.text_field(name: 'document.awardList[0].awardAmountInfos[4].currentFundEffectiveDate') }
  element(:obligation_end_date) { |b| b.frm.text_field(name: 'document.awardList[0].awardAmountInfos[4].obligationExpirationDate') }
  element(:anticipated_amount) { |b| b.frm.text_field(name: 'document.awardList[0].awardAmountInfos[4].anticipatedTotalAmount') }
  element(:obligated_amount) { |b| b.frm.text_field(name: 'document.awardList[0].awardAmountInfos[4].amountObligatedToDate') }
  
end