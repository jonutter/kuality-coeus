class ConfirmationPage < BasePage
  
  action(:yes) { |b| b.button(name: "methodToCall.processAnswer.button0").click }
  action(:no) { |b| b.button(name: "methodToCall.processAnswer.button1").click }

end