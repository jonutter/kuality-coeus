class SubawardInvoice < BasePage

  document_header_elements
  description_field
  global_buttons
  error_messages

  element(:invoice_id) { |b| b.frm.text_field(name: 'document.newMaintainableObject.invoiceNumber') }
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.startDate') }
  element(:end_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.endDate') }
  element(:amount_released) { |b| b.frm.text_field(name: 'document.newMaintainableObject.amountReleased') }
  element(:effective_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.effectiveDate') }

end