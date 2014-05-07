class Subaward < SubawardDocument

  description_field

  value(:subaward_id) { |b| b.subaward_div.table[0][1].text.strip }
  value(:version) { |b| b.subaward_div.table[1][1].text.strip }
  element(:subrecipient) { |b| b.frm.text_field(name: 'document.subAwardList[0].organizationId') }
  element(:lookup_subrecipient) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Organization!!).(((organizationId:document.subAwardList[0].organizationId,organizationName:document.subAwardList[0].organization.organizationName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorSubaward').click }
  element(:subaward_type) { |b| b.frm.select(name: 'document.subAwardList[0].subAwardTypeCode') }
  element(:purchase_order_id) { |b| b.frm.text_field(name: 'document.subAwardList[0].purchaseOrderNum') }
  element(:subaward_status) { |b| b.frm.select(name: 'document.subAwardList[0].statusCode') }
  element(:requisitioner_user_name) { |b| b.frm.text_field(name: 'document.subAwardList[0].requisitionerUserName') }
  element(:requisitioner_unit) { |b| b.frm.text_field(name: 'document.subAwardList[0].requisitionerUnit') }
  
  action(:lookup_requisitioner) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:document.subAwardList[0].requisitionerId,fullName:document.subAwardList[0].requisitionerName,unit.unitNumber:document.subAwardList[0].requisitionerUnit,unit.unitName:document.subAwardList[0].unit.unitName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorSubaward').click }

  element(:comments) { |b| b.frm.text_field(name: 'document.subAwardList[0].comments') }
  
  value(:obligated_amount) { |b| b.frm.text_field(title: 'Obligated Amount').value }
  value(:anticipated_amount) { |b| b.frm.text_field(title: 'Anticipated Amount').value }
  value(:amount_released) { |b| b.frm.text_field(title: 'Amount Released').value }
  value(:available_amount) { |b| b.frm.text_field(title: 'Available Amount').value }

  # Funding Source
  element(:award_number) { |b| b.frm.text_field(name: 'newSubAwardFundingSource.award.awardNumber') }
  action(:lookup_award) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.award.home.Award!!).(((awardNumber:newSubAwardFundingSource.award.awardNumber,awardDocument.documentNumber:newSubAwardFundingSource.award.awardDocument.documentNumber,awardId:newSubAwardFundingSource.awardId,accountNumber:newSubAwardFundingSource.award.accountNumber,statusCode:newSubAwardFundingSource.award.statusCode,sponsorCode:newSubAwardFundingSource.award.sponsorCode,sponsorName:newSubAwardFundingSource.award.sponsorName,awardAmountInfos[0].amountObligatedToDate:newSubAwardFundingSource.award.awardAmountInfos[0].amountObligatedToDate,awardAmountInfos[0].obligationExpirationDate:newSubAwardFundingSource.award.awardAmountInfos[0].obligationExpirationDate,awardStatus.description:newSubAwardFundingSource.award.awardStatus.description))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorFundingSource').click }
  action(:add_funding_source) { |b| b.frm.button(name: 'methodToCall.addFundingSource.anchorFundingSource').click }
  
  # Contacts
  element(:contacts_div) { |b| b.frm.div(id: 'tab-Contacts-div') }
  element(:non_employee_id) { |b| b.frm.text_field(name: 'newSubAwardContact.rolodex.rolodexId') }
  action(:person_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Rolodex!!).(((rolodexId:newSubAwardContact.rolodexId))).((`newSubAwardContact.rolodexId:rolodexId`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchorContacts').click }
  element(:project_role) { |b| b.frm.select(name: 'newSubAwardContact.contactTypeCode') }
  action(:add_contact) { |b| b.frm.button(name: 'methodToCall.addContacts.anchorContacts').click }
  value(:contact_name) { |b| b.frm.div(id: 'org.fullName.div').text.strip }

  # Closeout
  element(:closeout_type) { |b| b.frm.select(name: 'newSubAwardCloseout.closeoutTypeCode') }
  element(:date_requested) { |b| b.frm.text_field(name: 'newSubAwardCloseout.dateRequested') }
  element(:date_followup) { |b| b.frm.text_field(name: 'newSubAwardCloseout.dateFollowup') }
  
  private
  
  element(:subaward_div) { |b| b.frm.div(id: 'tab-Subaward-div') }

end