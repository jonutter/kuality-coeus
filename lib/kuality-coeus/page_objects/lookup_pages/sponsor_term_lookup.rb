class SponsorTermLookup < Lookups

  element(:last_button) { |b| b.frm.link(text: 'Last') }
  action(:last) { |b| b.last_button.click }
  element(:sponsor_term_id_column) { |b| b.frm.link(text: 'Sponsor Term Id')}
  action(:sort_sponsor_term_id) { |b| b.sponsor_term_id_column.click }

end