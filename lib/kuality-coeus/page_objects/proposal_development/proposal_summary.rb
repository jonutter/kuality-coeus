class ProposalSummary < BasePage

  global_buttons

  #element(:approve_button) { |b| b.frm.button(name: 'methodToCall.approve') }
  element(:disapprove_button) { |b| b.frm.button(name: 'methodToCall.disapprove') }

end