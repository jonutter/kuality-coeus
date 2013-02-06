# Note this page is custom to CMU's implementation.
class FinancialEntityRequest < BasePage

  frame_element
  header_tabs
  global_buttons
  document_header_elements

  element(:description) { |b| b.frm.text_field(id: "document.documentHeader.documentDescription") }
  element(:name) { |b| b.frm.text_field(id: "document.financialEntityRequestList[0].sponsorName") }
  element(:sponsor_type_code) { |b| b.frm.select(id: "document.financialEntityRequestList[0].sponsorTypeCode") }

end