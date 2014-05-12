# coding: UTF-8
class PersonLookup < Lookups

  url_info 'Person','rice.kim.api.identity.Person'

  element(:principal_name) { |b| b.frm.text_field(id: 'principalName') }
  element(:principal_id) { |b| b.frm.text_field(id: 'principalId') }

  alias_method :select_person, :check_item

  # Please note the 'space' in the .delete_if clause is NOT a space. It's some
  # unknown whitespace character. Don't screw with it or else this method will
  # stop working properly.
  value(:returned_full_names) { |b| b.noko.table(id: 'row').rows.collect{ |row| row[b.column_index('Name')].text }.tap(&:shift).delete_if{ |name| name==" " } }
  value(:returned_principal_names) { |b| b.noko.table(id: 'row').rows.collect{ |row| row[b.column_index('Principal Name')].text }.tap(&:shift) }

  private

  p_element(:column_index) { |column_name, b| b.frm.table(id: 'row').ths.to_a.index{|column|column.text==column_name} }

end