class ProposalLogLookup < Lookups

  url_info 'Proposal%20Log','kra.institutionalproposal.proposallog.ProposalLog'

  PROPOSAL_LOG_STATUS = 3

  element(:proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }
  action(:merge_item) { |match, p| p.results_table.row(text: /#{match}/m).link(text: 'merge').click; p.use_new_tab; p.close_parents }
  p_value(:prop_log_status) { |match, p| p.item_row(match)[PROPOSAL_LOG_STATUS].text }

end