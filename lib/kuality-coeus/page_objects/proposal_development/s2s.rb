class S2S < ProposalDevelopmentDocument

  proposal_header_elements
  error_messages

  element(:s2s_header) { |b| b.frm.h2(text: 'S2S') }

  element(:save_button) { |b| b.frm.button(name: 'methodToCall.save') }
  action(:save) { |b| b.save_button.click }

end