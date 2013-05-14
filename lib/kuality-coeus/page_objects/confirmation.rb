class Confirmation < BasePage

  global_buttons
  action(:yes) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button0').click; b.loading }
  action(:no) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button1').click; b.loading }
  action(:return_to_document) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button2').click; b.loading }
  alias_method :copy_all_periods, :yes
  alias_method :copy_one_period_only, :no

  #Recalling a proposal document for revisions/cancellation
  element(:recall_reason) { |b| b.frm.text_field(name: 'reason') }
  action(:recall_to_action_list) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button0').click b.loading }
  action(:recall_and_cancel) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button1').click b.loading }

end