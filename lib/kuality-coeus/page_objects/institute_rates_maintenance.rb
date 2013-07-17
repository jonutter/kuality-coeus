class InstituteRatesMaintenance < BasePage

  global_buttons
  document_header_elements
  error_messages
  description_field

  element(:activity_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.activityTypeCode') }
  element(:fiscal_year) { |b| b.frm.text_field(name: 'document.newMaintainableObject.fiscalYear') }
  element(:on_off_campus_flag) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.onOffCampusFlag') }
  element(:rate_class_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.rateClassCode') }
  element(:rate_type_code) { |b| b.frm.text_field(name: 'document.newMaintainableObject.rateTypeCode') }
  element(:start_date) { |b| b.frm.text_field(name: 'document.newMaintainableObject.startDate') }
  element(:unit_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.unitNumber') }
  element(:rate) { |b| b.frm.text_field(name: 'document.newMaintainableObject.instituteRate') }
  element(:active) { |b| b.frm.checkbox(name: 'document.newMaintainableObject.active') }

end