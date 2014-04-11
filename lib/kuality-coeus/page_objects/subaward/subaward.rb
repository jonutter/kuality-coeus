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

  private
  
  element(:subaward_div) { |b| b.frm.div(id: 'tab-Subaward-div') }

end