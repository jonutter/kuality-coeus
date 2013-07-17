class Disclosure < BasePage

  document_header_elements
  error_messages
  tab_buttons
  description_field

  action(:disclosure_actions) { |b| b.frm.button(value:  'Disclosure Actions').click }

  element(:unit_number) { |b| b.frm.text_field(name: 'disclosureHelper.newDisclosurePersonUnit.unitNumber') }
  element(:lead_unit) { |b| b.frm.checkbox(name: 'disclosureHelper.newDisclosurePersonUnit.leadUnitFlag') }
  action(:add_unit) { |b| b.frm.button(name: 'methodToCall.addDisclosurePersonUnit.line').click; b.loading }

  element(:acknowledgement) { |b| b.frm.checkbox(id: 'certCheckbox') }
  action(:submit) { |b| b.frm.button(name: 'methodToCall.submitDisclosureCertification').click; b.loading }

  element(:event_type) { |b| b.frm.select(name: 'disclosureHelper.newCoiDisclProject.disclosureEventType') }
  element(:award_number) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.coiProjectId') }
  alias_method :project_id, :award_number
  alias_method :protocol_number, :award_number
  alias_method :event_id, :award_number

  element(:award_title) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.coiProjectTitle') }
  alias_method :project_title, :award_title
  alias_method :protocol_name, :award_title
  alias_method :event_title, :award_title

  element(:sponsor) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.longTextField1') }
  alias_method :entity_name, :sponsor

  element(:project_role) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.shortTextField1') }
  alias_method :destination, :project_role

  element(:travel_sponsor) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.longTextField2') }

  element(:project_funding_amount) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.numberField1') }
  alias_method :reimbursement, :project_funding_amount
  
  element(:purpose_of_travel) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.longTextField3') }
  
  element(:award_date) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.dateField1') }
  alias_method :project_start_date, :award_date
  alias_method :start_date, :project_start_date
  
  element(:project_end_date) { |b| b.frm.text_field(name: 'disclosureHelper.newCoiDisclProject.dateField2') }
  alias_method :end_date, :project_end_date

  element(:project_type) { |b| b.frm.select(name: 'selectBox1-placeholder') }
  alias_method :protocol_type, :project_type

  action(:add_event) { |b| b.frm.button(name: 'methodToCall.addManualProject.anchorManualEventandFinancialEntities').click; b.loading }
  
  action(:save) { |b| b.frm.button(class: 'globalbuttons', title: 'save').click; b.loading }
  action(:close) { |b| b.frm.button(class: 'globalbuttons', title: 'close').click; b.loading }

end