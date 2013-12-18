class ProposalDevelopmentDocumentLookup < Lookups

  object_class_name page_url "#{$base_url}portal.do?channelTitle=Search%20Proposals&channelUrl=#{$base_url[/.+com/]}:/kc-dev/kr/lookup.do?methodToCall=start&businessObjectClassName=org.kuali.kra.proposaldevelopment.bo.DevelopmentProposal"

  element(:proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }

end