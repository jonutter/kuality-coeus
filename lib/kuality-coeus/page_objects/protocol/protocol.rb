class Protocol < KCProtocol

  protocol_header_elements
  description_field
  
  element(:protocol_type) { |b| b.frm.select(name: 'document.protocolList[0].protocolTypeCode') }
  element(:title) { |b| b.frm.text_field(name: 'document.protocolList[0].title') }
  action(:employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:protocolHelper.personId,fullName:protocolHelper.principalInvestigatorName,unit.unitNumber:protocolHelper.lookupUnitNumber,unit.unitName:protocolHelper.lookupUnitName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  element(:lead_unit) { |b| b.frm.text_field(name: 'protocolHelper.leadUnitNumber') }

end