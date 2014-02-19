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
  
  report_types 'Financial', 'Intellectual Property', 'Procurement', 'Property',
               'Proposals Due', 'Technical/Management'
  terms 'Equipment Approval', 'Invention', 'Prior Approval', 'Property', 'Publication',
        'Referenced Document', 'Rights In Data', 'Subaward Approval', 'Travel Restrictions'

  element(:approved_equipment) { |b| b.frm.text_field(name: 'approvedEquipmentBean.newAwardApprovedEquipment.item') }
  element(:equipment_amount) { |b| b.frm.text_field(name: 'approvedEquipmentBean.newAwardApprovedEquipment.amount') }
  action(:add_approved_equipment) { |b| b.frm(name: 'methodToCall.addApprovedEquipmentItem.anchorSpecialApproval:ApprovedEquipment').click; b.loading }

  action(:lookup_employee_traveler_name) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:approvedForeignTravelBean.newApprovedForeignTravel.personId,fullName:approvedForeignTravelBean.newApprovedForeignTravel.travelerName))).((`approvedForeignTravelBean.newApprovedForeignTravel.personId:contactIdId`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorSpecialApproval:ApprovedForeignTravel').click; b.loading }
  action(:lookup_non_empl_traveler_name) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.NonOrganizationalRolodex!!).(((rolodexId:approvedForeignTravelBean.newApprovedForeignTravel.rolodexId,fullName:approvedForeignTravelBean.newApprovedForeignTravel.travelerName))).((`approvedForeignTravelBean.newApprovedForeignTravel.rolodexId:contactId`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorSpecialApproval:ApprovedForeignTravel').click; b.loading }
  element(:destination) { |b| b.frm.text_field(name: 'approvedForeignTravelBean.newApprovedForeignTravel.destination') }
  element(:end_date) { |b| b.frm.text_field(name: 'approvedForeignTravelBean.newApprovedForeignTravel.startDate') }
  element(:travel_amount) { |b| b.frm.text_field(name: 'approvedForeignTravelBean.newApprovedForeignTravel.amount') }
  action(:add_approved_travel) { |b| b.frm.button(name: 'methodToCall.addApprovedForeignTravel.anchorSpecialApproval:ApprovedForeignTravel').click; b.loading }

  # ========
  private
  # ========

  element(:reports_div) { |b| b.frm.div(id: 'tab-Reports-div') }

end