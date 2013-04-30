class PersonLookup < BasePage

  tiny_buttons
  search_results_table

  action(:create) { |b| b.frm.link(title: 'Create a new record').click }

  element(:principal_name) { |b| b.frm.text_field(id: 'principalName') }
  element(:principal_id) { |b| b.frm.text_field(id: 'principalId') }
  element(:last_name) { |b| b.frm.text_field(id: 'lastName') }

end