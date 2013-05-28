class InstituteRatesLookup < BasePage

  tiny_buttons
  search_results_table

  element(:activity_type_code) { |b| b.frm.text_field(name: 'activityTypeCode') }
  element(:fiscal_year) { |b| b.frm.text_field(name: 'fiscalYear') }
  action(:on_off_campus) { |value, b| b.frm.radio(name: 'onOffCampusFlag', value: value).set }
  element(:rate_class_code) { |b| b.frm.text_field(name: 'rateClassCode') }
  action(:create_new) { |b| b.frm.link(title: 'Create a new record').click; b.loading }

end