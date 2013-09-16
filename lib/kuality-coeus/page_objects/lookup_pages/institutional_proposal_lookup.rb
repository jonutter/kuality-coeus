class InstitutionalProposalLookup < Lookups

  element(:institutional_proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }
  element(:institutional_proposal_status) { |b| b.frm.select(name: 'statusCode') }
  element(:account_id) { |b| b.frm.text_field(name: 'currentAccountNumber') }
  element(:sponsor_id) { |b| b.frm.text_field(name: 'sponsorCode') }
  element(:sponsor_name) { |b| b.frm.button(name: 'sponsor.sponsorName') }

end