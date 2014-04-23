class SponsorTemplateLookup < Lookups

  element(:sponsor_term_type_code) { |b| b.frm.select(name: 'sponsorTermTypeCode') }

end