class Confirmation < BasePage

  global_buttons
  action(:yes) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button0').click; b.loading }
  action(:no) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button1').click; b.loading }
  action(:return_to_document) { |b| b.frm.button(class: 'confirm', name: 'methodToCall.processAnswer.button2').click; b.loading }
  alias_method :copy_all_periods, :yes
  alias_method :copy_one_period_only, :no

end