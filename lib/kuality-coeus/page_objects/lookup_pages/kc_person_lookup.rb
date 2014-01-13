# coding: UTF-8
class KcPersonLookup < Lookups

  element(:kcperson_id) { |b| b.frm.text_field(name:'personId') }

  # Please note the 'space' in the .delete_if clause is NOT a space. It's some
  # unknown whitespace character. Don't screw with it or else this method will
  # stop working properly.
  value(:returned_full_names) { |b| b.target_column(3).map{ |td| td.text }.delete_if{ |name| name==" " } }

  value(:returned_user_names) { |b| b.target_column(4).map{ |td| td.text } }

end