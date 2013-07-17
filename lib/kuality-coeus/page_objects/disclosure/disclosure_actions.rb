class DisclosureActions < BasePage

  document_header_elements

  action(:disclosure) { |b| b.frm.button(value: 'Disclosure').click }

  action(:turn_on_validation) { |b| b.frm.button(name: 'methodToCall.activate').click }
  
end