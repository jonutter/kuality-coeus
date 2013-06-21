class SponsorLookup < BasePage

  tiny_buttons
  search_results_table

  element(:sponsor_name) { |b| b.frm.text_field(id: 'sponsorName') }
  element(:sponsor_type_code) { |b| b.frm.select(id: 'sponsorTypeCode') }
  element(:page_links) { |b| b.frm.span(class: 'pagelinks').links }

end