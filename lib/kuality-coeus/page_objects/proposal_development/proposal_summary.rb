class ProposalSummary < ProposalDevelopmentDocument

  proposal_header_elements

  element(:approve_button) { |b| b.frm.button(name: 'methodToCall.approve') }
  element(:disapprove_button) { |b| b.frm.button(name: 'methodToCall.disapprove') }
  element(:reject_button) { |b| b.frm.button(name: 'methodToCall.reject') }

end