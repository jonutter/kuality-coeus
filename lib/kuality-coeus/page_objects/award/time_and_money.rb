class TimeAndMoney < KCAwards

  award_header_elements
  error_messages

  action(:return_to_award) { |b| b.frm.button(name: 'methodToCall.returnToAward').click; b.loading }

  element(:description) { |b| b.frm.text_field(name: 'document.documentHeader.documentDescription') }
  element(:transaction_type_code) { |b| b.frm.select(name: 'document.awardAmountTransactions[0].transactionTypeCode') }

  action(:obligation_start_date) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /currentFundEffectiveDate/) }
  action(:obligation_end_date) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /obligationExpirationDate/) }
  action(:project_end) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /finalExpirationDate/) }
  action(:obligated) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /amountObligatedToDate/) }
  action(:anticipated) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /anticipatedTotalAmount/) }

  element(:source_award) { |b| b.frm.select(name: 'transactionBean.newPendingTransaction.sourceAwardNumber') }
  element(:destination_award) { |b| b.frm.select(name: 'transactionBean.newPendingTransaction.destinationAwardNumber') }
  element(:obligated_change) { |b| b.frm.text_field(name: 'transactionBean.newPendingTransaction.obligatedAmount') }
  element(:anticipated_change) { |b| b.frm.text_field(name: 'transactionBean.newPendingTransaction.anticipatedAmount') }
  action(:add_transaction) { |b| b.frm.button(name: /methodToCall.addTransaction.anchorTransactions\d+/).click; b.loading }
  
  # ==========
  private
  # ==========

  element(:hierarchy_table) { |b| b.frm.div(class: 'awardHierarchy').table }
  
end