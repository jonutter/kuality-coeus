class SponsorTemplate < BasePage

  description_field
  tab_buttons
  global_buttons

  #Mandatory/Required Components
  element(:payment_basis) { |b| b.frm.select(name: 'document.newMaintainableObject.basisOfPaymentCode') }
  element(:payment_method) { |b| b.frm.select(name: 'document.newMaintainableObject.methodOfPaymentCode') }

  #Required to Submit
  element(:template_description) { |b| b.frm.text_field(name: 'document.newMaintainableObject.description') }
  element(:template_status) { |b| b.frm.select(name: 'document.newMaintainableObject.statusCode') }


end
