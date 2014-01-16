class ToBeNamedPersonsLookup < Lookups

  element(:person_name) { |b| b.frm.text_field(id: 'personName') }

  alias_method :select_person, :check_item

  value(:returned_person_names) { |b| b.target_column(3).map{ |td| td.text.strip } }

end