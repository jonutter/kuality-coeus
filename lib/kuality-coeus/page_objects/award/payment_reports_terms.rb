class PaymentReportsTerms < KCAwards

  element(:payment_basis) { |b| b.frm.select(name: 'document.awardList[0].basisOfPaymentCode') }
  element(:payment_method) { |b| b.frm.select(name: 'document.awardList[0].methodOfPaymentCode') }
  element(:payment_type) { |b| b.frm.select(name: 'awardReportsBean.newAwardReportTerms[2].reportCode') }
  element(:frequency) { |b| b.frm.select(name: 'awardReportsBean.newAwardReportTerms[2].frequencyCode') }
  element(:frequency_base) { |b| b.frm.select(name: 'awardReportsBean.newAwardReportTerms[2].frequencyBaseCode') }
  element(:osp_file_copy) { |b| b.frm.select(name: 'awardReportsBean.newAwardReportTerms[2].ospDistributionCode') }
  action(:add_payment_type) { |b| b.frm.button(name: 'methodToCall.addAwardReportTerm.reportClass6.reportClassIndex2.anchorReportClasses:PaymentInvoiceRequirements').click; b.loading }

  element(:invoice_instructions) { |b| b.frm.text_field(name: 'document.awardList[0].awardPaymentAndInvoiceRequirementsComments.comments') }
  
  action(:generate_schedule) { |b| b.frm.button(name: 'methodToCall.generatePaymentSchedules.anchorReportClasses:PaymentInvoiceRequirements').click; b.loading }

  # Adding Reports...

  # Strings that will work with these methods:
  # 'Financial', 'IntellectualProperty', 'Procurement', 'Property', 'ProposalsDue', 'TechnicalManagement'
  p_element(:add_report_type) { |report, b| b.report_div(report).select(name: /newAwardReportTerms\[\d+\].reportCode/) }
  p_element(:add_frequency) { |report, b| b.report_div(report).select(name: /awardReportsBean.newAwardReportTerms\[\d+\].frequencyCode/) }
  p_element(:add_frequency_base) { |report, b| b.report_div(report).select(name: /awardReportsBean.newAwardReportTerms\[\d+\].frequencyBaseCode/) }
  p_element(:add_osp_file_copy) { |report, b| b.report_div(report).select(name: /awardReportsBean.newAwardReportTerms\[\d+\].ospDistributionCode/) }
  p_element(:add_due_date) { |report, b| b.report_div(report).text_field(name: /awardReportsBean.newAwardReportTerms\[\d+\].dueDate/) }
  p_action(:add_report) { |report, b| b.frm.button(name: /methodToCall.addAwardReportTerm.reportClass\d+.reportClassIndex\d+.anchorReportClasses:#{report}/).click }

  # Editing Reports...
  p_element(:report_type) { |report, number, b| b.report_infoline(report, number).parent.select(name: /reportCode/) }
  p_element(:report_frequency) { |report, number, b| b.report_infoline(report, number).parent.select(name: /frequencyCode/) }
  p_element(:report_frequency_base) { |report, number, b| b.report_infoline(report, number).parent.select(name: /frequencyBaseCode/) }
  p_element(:report_osp_file_copy) { |report, number, b| b.report_infoline(report, number).parent.select(title: 'OSP File Copy') }
  p_element(:report_due_date) { |report, number, b| b.report_infoline(report, number).parent.text_field(title: 'Due Date') }
  p_action(:delete_report) { |report, number, b| b.report_infoline(report, number).parent.button(name: /deleteAwardReportTerm/).click }

  # Report Recipients...
  p_element(:add_contact_type) { |report, number, b| b.report_infoline(report, number).parent.parent.select(title: 'Contact Type') }
  p_action(:recipient_lookup) { |report, number, b| b.report_infoline(report, number).parent.parent.button(title: 'Search ').click; b.loading }
  p_element(:add_num_copies) { |report, number, b| b.report_infoline(report, number).parent.parent.text_field(title: 'Number of Copies') }
  p_action(:add_recipient) { |report, number, b| b.report_infoline(report, number).parent.parent.button(name: /addRecipient/).click }

  # Details - Report Tracking...
  p_element(:edit_selected_preparer) { |report, number, b| b.report_infoline(report, number).parent.parent.text_field(title: 'Preparer Name') }
  p_action(:edit_selected_preparer_lookup) { |report, number, b| b.report_infoline(report, number).parent.parent.button(alt: 'Search ').click }
  p_element(:edit_selected_status) { |report, number, b| b.report_infoline(report, number).parent.parent.select(title: 'Status') }
  p_element(:edit_selected_activity_date) { |report, number, b| b.report_infoline(report, number).parent.parent.text_field(title: 'Activity Date') }
  p_action(:update_selected_details) { |report, number, b| b.report_infoline(report, number).parent.parent.button(alt: 'Update Multiple Report Tracking') }
  p_element(:select_report_detail_item) { |report, number, index, b| b.report_infoline(report, number).parent.parent.checkboxes(title: 'Select')[index] }
  p_element(:detail_item_due_date) { |report, number, index, b| b.report_infoline(report, number).parent.parent.text_fields(title: 'Due Date')[index] }
  p_value(:detail_item_overdue) { |report, number, index, b| b.report_infoline(report, number).parent.parent.tr(index: 1).table(index: 1).tr(index: index+3).td(index: 2).text }
  p_element(:detail_item_preparer) { |report, number, index, b| b.report_infoline(report, number).parent.parent.text_fields(title: 'Preparer Name')[index+1] }
  p_element(:detail_item_preparer_lookup) { |report, number, index, b| b.report_infoline(report, number).parent.parent.buttons(title: 'Search ')[index+1].click }
  p_element(:detail_item_status) { |report, number, index, b| b.report_infoline(report, number).parent.parent.selects(title: '* Status')[index] }
  p_element(:detail_item_activity_date) { |report, number, index, b| b.report_infoline(report, number).parent.parent.text_fields(title: 'Activity Date')[index+1] }

  # Terms...
  terms 'Equipment Approval', 'Invention', 'Prior Approval', 'Property', 'Publication',
        'Referenced Document', 'Rights In Data', 'Subaward Approval', 'Travel Restrictions'

  # Special Approval...
  element(:add_item) { |b| b.frm.text_field(name: 'approvedEquipmentBean.newAwardApprovedEquipment.item') }
  element(:add_vendor) { |b| b.frm.text_field(name: 'approvedEquipmentBean.newAwardApprovedEquipment.vendor') }
  element(:add_model) { |b| b.frm.text_field(name: 'approvedEquipmentBean.newAwardApprovedEquipment.model') }
  element(:add_approved_equipment_amount) { |b| b.frm.text_field(name: 'approvedEquipmentBean.newAwardApprovedEquipment.amount') }
  action(:add_approved_equipment) { |b| b.frm.button(name: 'methodToCall.addApprovedEquipmentItem.anchorSpecialApproval:ApprovedEquipment').click; b.loading }

  action(:lookup_employee_traveler_name) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:approvedForeignTravelBean.newApprovedForeignTravel.personId,fullName:approvedForeignTravelBean.newApprovedForeignTravel.travelerName))).((`approvedForeignTravelBean.newApprovedForeignTravel.personId:contactIdId`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorSpecialApproval:ApprovedForeignTravel').click; b.loading }
  action(:lookup_non_empl_traveler_name) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.NonOrganizationalRolodex!!).(((rolodexId:approvedForeignTravelBean.newApprovedForeignTravel.rolodexId,fullName:approvedForeignTravelBean.newApprovedForeignTravel.travelerName))).((`approvedForeignTravelBean.newApprovedForeignTravel.rolodexId:contactId`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorSpecialApproval:ApprovedForeignTravel').click; b.loading }
  element(:destination) { |b| b.frm.text_field(name: 'approvedForeignTravelBean.newApprovedForeignTravel.destination') }
  element(:end_date) { |b| b.frm.text_field(name: 'approvedForeignTravelBean.newApprovedForeignTravel.startDate') }
  element(:travel_amount) { |b| b.frm.text_field(name: 'approvedForeignTravelBean.newApprovedForeignTravel.amount') }
  action(:add_approved_travel) { |b| b.frm.button(name: 'methodToCall.addApprovedForeignTravel.anchorSpecialApproval:ApprovedForeignTravel').click; b.loading }

  element(:generate_report_tracking_button) { |b| b.frm.button(alt: 'Generate Reports') }
  action(:generate_report_tracking) { |b| b.generate_report_tracking_button.click }

  # ========
  private
  # ========

  p_element(:report_div) { |report, b| b.frm.div(id: "tab-ReportClasses:#{report}-div") }
  p_element(:report_infoline) { |report, number, b| b.report_div(report).th(class: 'infoline', text: number) }

end