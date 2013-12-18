class ProposalDevelopmentDocumentLookup < Lookups

  url_info 'Search%20Proposals','kra.proposaldevelopment.bo.DevelopmentProposal'

  element(:proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }

end