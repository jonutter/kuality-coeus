class SponsorTerm < BasePage

  document_header_elements
  search_results_table
  description_field
  tab_buttons
  global_buttons
  error_messages

  element(:sponsor_term_id) { |b| b.frm.text_field(name: 'document.newMaintainableObject.sponsorTermId') }
  element(:sponsor_term_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.sponsorTermCode') }
  element(:sponsor_term_type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.sponsorTermTypeCode') }
  element(:sponsor_term_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.description') }


end