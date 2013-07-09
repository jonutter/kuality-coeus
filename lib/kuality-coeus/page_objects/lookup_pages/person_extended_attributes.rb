class PersonExtendedAttributesLookup < BasePage

  tiny_buttons
  search_results_table

  action(:create) { |b| b.frm.link(alt: 'create new').click }

end