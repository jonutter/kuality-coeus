class ProposalTypeLookup < Lookups

  element(:proposal_type_code) { |b| b.frm.text_field(name: 'proposalTypeCode') }

end