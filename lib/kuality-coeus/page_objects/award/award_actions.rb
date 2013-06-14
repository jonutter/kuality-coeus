class AwardActions < KCAwards

  award_header_elements
  route_log

  # TODO: Refactor this class and the ProposalActions class to DRY them both up...
  element(:validation_button) { |b| b.frm.button(name: 'methodToCall.activate') }
  action(:turn_on_validation) { |b| b.validation_button.click; b.loading }


end