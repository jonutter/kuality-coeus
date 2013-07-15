class PersonLookup < BasePage

  tiny_buttons
  search_results_table

  element(:kcperson_id) { |b| b.frm.text_field(name:'personId') }

  element(:create_button) { |b| b.frm.link(title: 'Create a new record') }
  action(:create) { |p| p.create_button.click }

  element(:principal_name) { |b| b.frm.text_field(id: 'principalName') }
  element(:principal_id) { |b| b.frm.text_field(id: 'principalId') }
  element(:last_name) { |b| b.frm.text_field(id: 'lastName') }
  element(:user_name) { |b| b.frm.text_field(id: 'userName') }

end