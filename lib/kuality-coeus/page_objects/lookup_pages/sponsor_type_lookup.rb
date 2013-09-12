class SponsorTypeLookup < Lookups

  element(:sponsor_type_code) { |b| b.frm.text_field(name: 'sponsorTypeCode') }
  element(:description) { |b| b.frm.text_field(name: 'description') }

end