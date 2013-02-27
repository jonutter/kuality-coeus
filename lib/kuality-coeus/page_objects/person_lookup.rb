class PersonLookup < BasePage

  tiny_buttons
  search_results_table

  element(:last_name) { |b| b.frm.text_field(id: 'lastName') }

  action(:return_value) { |match, p| p.results_table.row(text: /#{match}/).link(text: 'return value').click }

  action(:return_random) { |b| b.results_table.row(index: rand(b.results_table.rows.length)).link(text: 'return value').click }

end