class Lookups < BasePage

  tiny_buttons
  search_results_table

  element(:create_button) { |b| b.frm.link(title: 'Create a new record') }
  action(:create_new) { |b| b.create_button.click; b.loading }
  alias_method :create, :create_new

end