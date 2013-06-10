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
  element(:project_end_date) { |b| b.frm.text_field(name: 'document.awardList[0].awardAmountInfos[0].finalExpirationDate') }

end