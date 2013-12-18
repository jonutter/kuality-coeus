class CampusTypeLookup < Lookups

  url_info 'Campus%20Type','rice.location.impl.campus.CampusTypeBo'

  element(:campus_type_code) { |b| b.frm.text_field(name: 'code') }
  element(:campus_type_name) { |b| b.frm.text_field(name: 'name') }

end