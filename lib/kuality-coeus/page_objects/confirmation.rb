class Confirmation < BasePage

  global_buttons

  element(:yes_button) { |b| b.frm.button(name: 'methodToCall.processAnswer.button0', class: 'confirm') }
  element(:reason) { |b| b.frm.text_field(name: 'reason') }
  alias_method :recall_reason, :reason
  action(:yes) { |b| b.yes_button.click; b.loading }
  action(:no) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button1').click; b.loading }
  action(:return_to_document) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button2').click; b.loading }
  alias_method :copy_all_periods, :yes
  alias_method :copy_one_period_only, :no
  alias_method :recall_to_action_list, :yes
  alias_method :recall_and_cancel, :no

end