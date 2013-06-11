class PaymentReportsTerms < KCAwards

  award_header_elements

  element(:payment_basis) { |b| b.frm.select(name: 'document.awardList[0].basisOfPaymentCode') }
  element(:payment_method) { |b| b.frm.select(name: 'document.awardList[0].methodOfPaymentCode') }
  element(:payment_type) { |b| b.frm.select(name: 'awardReportsBean.newAwardReportTerms[2].reportCode') }
  action(:add_payment_type) { |b| b.frm.button(name: 'methodToCall.addAwardReportTerm.reportClass6.reportClassIndex2.anchorReportClasses:PaymentInvoiceRequirements').click; b.loading }

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
  
  # =======
  private
  # =======

  class << self

    def report_types *types
      types.each_with_index do |type, index|
        name=damballa(type)
        tag=type.gsub(/([\s\/])/,'')
        element("#{name}_report_type".to_sym) { |b| b.frm.select(name: "awardReportsBean.newAwardReportTerms[#{index}].reportCode") }
        element("#{name}_frequency".to_sym) { |b| b.frm.select(name: "awardReportsBean.newAwardReportTerms[#{index}].frequencyCode") }
        element("#{name}_frequency_base".to_sym) { |b| b.frm.select(name: "awardReportsBean.newAwardReportTerms[#{index}].frequencyBaseCode") }
        action("add_#{name}_report_term".to_sym) { |b| b.(name: /anchorReportClasses:#{tag}/).click; b.loading }
      end
    end

    def terms *terms
      terms.each_with_index do |term, index|
        name=damballa(term)
        tag=type.gsub(/([\s\/])/,'')
        element("#{name}_code".to_sym) { |b| b.frm.text_field(name: "sponsorTermFormHelper.newSponsorTerms[#{index}].sponsorTermCode") }
        action("add_#{name}_term") { |b| b.frm.button(name: /anchorAwardTerms:#{tag}Terms/).click; b.loading }
      end
    end

  end

end