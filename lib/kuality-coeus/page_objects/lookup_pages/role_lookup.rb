class RoleLookup < Lookups

  element(:role_id) { |b| b.frm.text_field(name: 'id') }
  element(:role_name) { |b| b.frm.text_field(name: 'name') }

end