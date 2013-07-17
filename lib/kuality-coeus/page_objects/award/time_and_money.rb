class TimeAndMoney < KCAwards

  award_header_elements
  error_messages
  description_field

  action(:return_to_award) { |b| b.return_button.click; b.loading }
  element(:return_button) { |b| b.frm.button(name: 'methodToCall.returnToAward') }

  element(:transaction_type_code) { |b| b.frm.select(name: 'document.awardAmountTransactions[0].transactionTypeCode') }

  action(:obligation_start_date) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /currentFundEffectiveDate/) }
  action(:obligation_end_date) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /obligationExpirationDate/) }
  action(:project_end) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /finalExpirationDate/) }
  action(:obligated) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /amountObligatedToDate/) }
  action(:anticipated) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /anticipatedTotalAmount/) }

  element(:transaction_comment) { |b| b.frm.text_field(name: 'transactionBean.newPendingTransaction.comments') }
  element(:source_award) { |b| b.frm.select(name: 'transactionBean.newPendingTransaction.sourceAwardNumber') }
  element(:destination_award) { |b| b.frm.select(name: 'transactionBean.newPendingTransaction.destinationAwardNumber') }
  element(:obligated_change) { |b| b.frm.text_field(name: 'transactionBean.newPendingTransaction.obligatedAmount') }
  element(:anticipated_change) { |b| b.frm.text_field(name: 'transactionBean.newPendingTransaction.anticipatedAmount') }
  action(:add_transaction) { |b| b.frm.button(name: /methodToCall.addTransaction.anchorTransactions\d+/).click; b.loading }

  action(:go_to) { |award_id, b| b.award_select.set(award_id); b.switch_award }

  element(:award_select) { |b| b.frm.select(name: 'goToAwardNumber') }
  action(:switch_award) { |b| b.frm.button(name: 'methodToCall.switchAward').click; b.loading }

  # ==========
  private
  # ==========

  element(:hierarchy_table) { |b| b.frm.div(class: 'awardHierarchy').table }
  
end