class TimeAndMoney < KCAwards

  description_field

  action(:return_to_award) { |b| b.return_button.click; b.loading }
  element(:return_button) { |b| b.frm.button(name: 'methodToCall.returnToAward') }

  # Award Hierarchy

  element(:transaction_type_code) { |b| b.frm.select(name: 'document.awardAmountTransactions[0].transactionTypeCode') }
  element(:notice_date) { |b| b.frm.text_field(name: 'document.awardAmountTransactions[0].noticeDate') }
  element(:current) { |b| b.frm.radio(name: 'currentOrPendingView', value: '0') }
  element(:pending) { |b| b.frm.radio(name: 'currentOrPendingView', value: '1') }

  action(:obligation_start_date) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /currentFundEffectiveDate/) }
  action(:obligation_end_date) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /obligationExpirationDate/) }
  action(:project_end) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /finalExpirationDate/) }
  action(:obligated) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /amountObligatedToDate/) }
  action(:anticipated) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /anticipatedTotalAmount/) }

  # Transactions

  element(:comments) { |b| b.frm.text_field(name: 'transactionBean.newPendingTransaction.comments') }
  element(:source_award) { |b| b.frm.select(name: 'transactionBean.newPendingTransaction.sourceAwardNumber') }
  element(:destination_award) { |b| b.frm.select(name: 'transactionBean.newPendingTransaction.destinationAwardNumber') }
  element(:obligated_change) { |b| b.frm.text_field(name: 'transactionBean.newPendingTransaction.obligatedAmount') }
  element(:anticipated_change) { |b| b.frm.text_field(name: 'transactionBean.newPendingTransaction.anticipatedAmount') }
  action(:add_transaction) { |b| b.frm.button(name: /methodToCall.addTransaction.anchorTransactions\d+/).click; b.loading }

  # Returns the last transaction number listed in the table...
  value(:last_transaction_id) { |b| b.transaction_table.rows.last[1].text }
  element(:transaction_table) { |b| b.frm.div(id: /tab-Transactions\d+-div/).table }

  action(:go_to) { |award_id, b| b.award_select.set(award_id); b.switch_award }

  element(:award_select) { |b| b.frm.select(name: 'goToAwardNumber') }
  action(:switch_award) { |b| b.frm.button(name: 'methodToCall.switchAward').click; b.loading }

  # Direct/F&A Funds Distribution
  # Note: These methods must be used with one of the "parent" methods listed below
  element(:funds_distribution_start_date) { |b| b.text_field(name: 'awardDirectFandADistributionBean.newAwardDirectFandADistribution.startDate') }
  element(:funds_distribution_end_date) { |b| b.frm.text_field(name: 'awardDirectFandADistributionBean.newAwardDirectFandADistribution.endDate') }
  element(:funds_distribution_direct_cost) { |b| b.frm.text_field(name: 'awardDirectFandADistributionBean.newAwardDirectFandADistribution.directCost') }
  element(:funds_distribution_fa_cost) { |b| b.frm.text_field(name: 'awardDirectFandADistributionBean.newAwardDirectFandADistribution.indirectCost') }

  p_element(:edit_funds_dist_start_date) { |number, b| b.target_funds_row(number).text_field(title: '* Start Date') }
  p_element(:edit_funds_dist_end_date) { |number, b| b.target_funds_row(number).text_field(title: '* End Date') }
  p_element(:edit_funds_dist_direct_cost) { |number, b| b.target_funds_row(number).text_field(title: '* Direct Cost') }
  p_element(:edit_funds_dist_fa_cost) { |number, b| b.target_funds_row(number).text_field(title: '* F&A Cost') }

  element(:existing_funds_rows) { |b| b.funds_distribution_div.table(index: 1).tbody(index: 2).trs[0..-3] }

  action(:add_funds_distribution) { |b| b.frm.button(name: 'methodToCall.addAwardDirectFandADistribution.anchorDirectFAFundsDistribution').click; b.loading }

  # Summary

  # Action Summary

  # History

  # ==========
  private
  # ==========
                                
  element(:hierarchy_table) { |b| b.frm.div(class: 'awardHierarchy').table }
  element(:funds_distribution_div) { |b| b.frm.div(id: 'tab-DirectFAFundsDistribution-div') }
  p_element(:target_funds_row) { |number, b| b.existing_funds_rows.find{ |row| row.th(class: 'infoline').text==number }  }

end