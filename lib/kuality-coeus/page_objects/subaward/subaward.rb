class Subaward < SubawardDocument

  description_field

  value(:subaward_id) { |b| b.subaward_div.table[0][1].text.strip }
  element(:subrecipient) { |b| b.frm.text_field(name: 'document.subAwardList[0].organizationId') }
  element(:subaward_type) { |b| b.frm.select(name: 'document.subAwardList[0].subAwardTypeCode') }
  element(:purchase_order_id) { |b| b.frm.text_field(name: 'document.subAwardList[0].purchaseOrderNum') }
  element(:subaward_status) { |b| b.frm.select(name: 'document.subAwardList[0].statusCode') }
  element(:requisitioner_user_name) { |b| b.frm.text_field(name: 'document.subAwardList[0].requisitionerUserName') }

  private
  
  element(:subaward_div) { |b| b.frm.div(id: 'tab-Subaward-div') }

end