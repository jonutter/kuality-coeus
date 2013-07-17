class PersonExtendedAttributesLookup < Lookups

  element(:person_id) { |b| b.frm.text_field(name: 'personId') }

end