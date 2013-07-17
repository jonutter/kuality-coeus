class InstituteRatesLookup < Lookups

  element(:activity_type_code) { |b| b.frm.text_field(name: 'activityTypeCode') }
  element(:fiscal_year) { |b| b.frm.text_field(name: 'fiscalYear') }
  action(:on_off_campus) { |value, b| b.frm.radio(name: 'onOffCampusFlag', value: value).set }
  element(:rate_class_code) { |b| b.frm.text_field(name: 'rateClassCode') }
  element(:rate_type_code) { |b| b.frm.text_field(name: 'rateTypeCode') }
  element(:rate) { |b| b.frm.text_field(name: 'instituteRate') }
  element(:unit_number) { |b| b.frm.text_field(name: 'unitNumber') }
  action(:active) { |val, b| b.frm.radio(name: 'active', value: val).set }

end