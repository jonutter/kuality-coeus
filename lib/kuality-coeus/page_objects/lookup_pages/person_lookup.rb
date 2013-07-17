class PersonLookup < Lookups

  element(:kcperson_id) { |b| b.frm.text_field(name:'personId') }

  element(:principal_name) { |b| b.frm.text_field(id: 'principalName') }
  element(:principal_id) { |b| b.frm.text_field(id: 'principalId') }
  element(:last_name) { |b| b.frm.text_field(id: 'lastName') }
  element(:user_name) { |b| b.frm.text_field(id: 'userName') }

end