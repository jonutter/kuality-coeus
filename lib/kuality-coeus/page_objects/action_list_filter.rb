class ActionListFilter < BasePage

  global_buttons

  element(:document_title) { |b| b.frm.text_field(name: 'filter.documentTitle') }
end