class RejectionConfirmation < BasePage

  action(:yes) { |b| b.frm.button(name: 'methodToCall.rejectYes').click }
  action(:no)  { |b| b.frm.button(name: 'methodToCall.rejectNo').click }
end