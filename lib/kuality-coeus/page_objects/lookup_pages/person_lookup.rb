# coding: UTF-8
class PersonLookup < Lookups

  url_info 'Person','rice.kim.api.identity.Person'

  element(:principal_name) { |b| b.frm.text_field(id: 'principalName') }
  element(:principal_id) { |b| b.frm.text_field(id: 'principalId') }

  alias_method :select_person, :check_item

  value(:returned_full_names) { |b| b.target_column(4).map{ |a| a.text }.delete_if{ |name| name==" " } }

  value(:returned_principal_names) { |b| b.target_column(3).map { |a| a.text } }

end