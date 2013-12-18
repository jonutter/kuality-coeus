class ProposalLogLookup < Lookups

  page_url "#{$base_url}portal.do?channelTitle=Proposal%20Log&channelUrl=#{$base_url[/.+com/]}:/kc-dev/kr/lookup.do?methodToCall=start&businessObjectClassName=org.kuali.kra.institutionalproposal.proposallog.ProposalLog"

  element(:proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }
  action(:merge_item) { |match, p| p.results_table.row(text: /#{match}/m).link(text: 'merge').click; p.use_new_tab; p.close_parents }

end