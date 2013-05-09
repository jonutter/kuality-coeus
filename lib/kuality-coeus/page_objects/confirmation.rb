class Confirmation < BasePage

  global_buttons

  element(:recall_reason) { |b| b.frm.text_field(name: 'reason') }
end