class S2S < ProposalDevelopmentDocument

  proposal_header_elements
  error_messages

  element(:s2s_header) { |b| b.frm.h2(text: 'S2S') }

end