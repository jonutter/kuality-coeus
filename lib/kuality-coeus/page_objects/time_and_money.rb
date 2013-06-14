class TimeAndMoney < BasePage

  document_header_elements
  tab_buttons
  global_buttons
  error_messages

  action(:return_to_award) { |b| b.frm.button(name: 'methodToCall.returnToAward').click; b.loading }

  action(:obligated) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /amountObligatedToDate/) }
  action(:anticipated) { |award_id, b| b.hierarchy_table.row(text: /#{award_id}/).text_field(name: /anticipatedTotalAmount/) }

  # ==========
  private
  # ==========

  element(:hierarchy_table) { |b| b.frm.div(class: 'awardHierarchy').table }
  
end