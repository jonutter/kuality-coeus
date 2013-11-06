class ProposalLogLookup < Lookups

  element(:proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }
  action(:merge_item) { |match, p| p.results_table.row(text: /#{match}/m).link(text: 'merge').click; p.use_new_tab; p.close_parents }

end