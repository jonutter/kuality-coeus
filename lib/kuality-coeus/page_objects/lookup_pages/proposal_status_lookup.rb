class ProposalStatusLookup < Lookups

  element(:proposal_status_code) { |b| b.frm.text_field(name: 'proposalStatusCode') }

end