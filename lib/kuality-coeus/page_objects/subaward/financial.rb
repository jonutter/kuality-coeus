class Financial < SubawardDocument

  action(:add_invoice) { |b| b.frm.button(class: 'globalbuttons', title: 'Add Invoice').click; b.use_new_tab }

  element(:effective_date) { |b| b.frm.text_field(name: 'newSubAwardAmountInfo.effectiveDate') }
  element(:obligated_change) { |b| b.frm.text_field(name: 'newSubAwardAmountInfo.obligatedChange') }
  element(:anticipated_change) { |b| b.frm.text_field(name: 'newSubAwardAmountInfo.anticipatedChange') }
  action(:add) { |b| b.frm.button(name: 'methodToCall.addAmountInfo.anchorHistoryofChanges').click }

end