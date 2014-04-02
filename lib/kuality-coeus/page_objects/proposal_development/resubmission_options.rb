class ResubmissionOptions < ProposalDevelopmentDocument

  glbl 'continue'

  element(:generate_new_version_of_original) { |b| b.target_radio_button('O') }
  element(:generate_new_ip_version) { |b| b.target_radio_button('A') }
  element(:generate_new_ip) { |b| b.target_radio_button('N') }
  element(:do_not_generate) { |b| b.target_radio_button('X') }

  private

  p_element(:target_radio_button) { |value, b| b.frm.radio(name: 'resubmissionOption', value: value) }

end