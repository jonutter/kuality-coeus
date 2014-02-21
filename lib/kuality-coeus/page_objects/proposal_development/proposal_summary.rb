class ProposalSummary < ProposalDevelopmentDocument

  element(:disapprove_button) { |b| b.frm.button(name: 'methodToCall.disapprove') }
  element(:reject_button) { |b| b.frm.button(name: 'methodToCall.reject') }

end