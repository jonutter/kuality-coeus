class ActionListFilter < BasePage

  global_buttons

  element(:document_title) { |b| b.frm.text_field(name: 'filter.documentTitle') }
  action(:filter) { |b| b.frm.button(name: 'methodToCall.filter').click b.loading }
end