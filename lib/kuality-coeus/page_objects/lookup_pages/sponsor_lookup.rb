class SponsorLookup < Lookups

  element(:sponsor_name) { |b| b.frm.text_field(id: 'sponsorName') }
  element(:sponsor_type_code) { |b| b.frm.select(id: 'sponsorTypeCode') }
  element(:page_links) { |b| b.frm.span(class: 'pagelinks').links }

  action(:get_sponsor_code) { |name, b| b.item_row(name).link(title: /Sponsor Code=/).text }

end