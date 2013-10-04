class ProposalLogLookup < Lookups

  element(:proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }

end