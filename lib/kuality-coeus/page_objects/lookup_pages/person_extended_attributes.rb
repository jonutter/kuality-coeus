class PersonExtendedAttributesLookup < Lookups

  url_info 'Person%20Extended%20Attributes','kra.bo.KcPersonExtendedAttributes'

  element(:person_id) { |b| b.frm.text_field(name: 'personId') }

end