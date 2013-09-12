class Protocol < KCProtocol

  protocol_header_elements
  description_field

  # Document Overview
  element(:description) { |b| b.frm.text_field(name: 'document.documentHeader.documentDescription') }
  element(:org_doc_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }
  element(:explanation) { |b| b.frm.text_field(name: 'document.documentHeader.explanation') }

  # Required Fields
  element(:irb_protocol_type) { |b| b.frm.select(name: 'document.protocolList[0].protocolTypeCode') }
  element(:title) { |b| b.frm.text_field(name: 'document.protocolList[0].title') }
  action(:employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:protocolHelper.personId,fullName:protocolHelper.principalInvestigatorName,unit.unitNumber:protocolHelper.lookupUnitNumber,unit.unitName:protocolHelper.lookupUnitName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  element(:lead_unit) { |b| b.frm.text_field(name: 'protocolHelper.leadUnitNumber') }
  element(:save_button) { |b| b.frm.button(name: 'methodToCall.save') }

  # Status' and Dates
  #TODO: Capture status' and dates table

  # Additional Information
  action(:add_area_of_research) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.irb.ResearchArea!!).((``)).(:;protocolResearchAreas;:).((%true%)).((~~)).anchorAdditionalInformation').click }
  element(:fda_number) { |b| b.frm.text_field(name: 'document.protocolList[0].fdaApplicationNumber') }
  element(:reference_id1) { |b| b.frm.text_field(name: 'document.protocolList[0].referenceNumber1') }
  element(:reference_id2) { |b| b.frm.text_field(name: 'document.protocolList[0].referenceNumber2') }
  element(:summary) { |b| b.frm.text_field(name: 'document.protocolList[0].description') }

  # Other Identifiers
  action(:identifier_type) { |b| b.frm.select_list(name: 'newProtocolReferenceBean.protocolReferenceTypeCode') }
  element(:identifier) { |b| b.frm.text_field(name: 'newProtocolReferenceBean.referenceKey') }
  element(:identifier_application_date) { |b| b.frm.text_field(name: 'newProtocolReferenceBean.applicationDate') }
  element(:identifier_approval_date) { |b| b.frm.text_field(name: 'newProtocolReferenceBean.approvalDate') }
  element(:identifier_comment) { |b| b.frm.text_field(name: 'newProtocolReferenceBean.comments') }
  action(:identifier_add) { |b| b.frm.button(name: 'methodToCall.addProtocolReferenceBean.anchorAdditionalInformation').click }

  # Organizations
  element(:org_id) { |b| b.frm.text_field(name: 'protocolHelper.newProtocolLocation.organizationId') }
  action(:org_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Organization!!).(((organizationId:protocolHelper.newProtocolLocation.organizationId,contactAddressId:protocolHelper.newProtocolLocation.rolodexId,humanSubAssurance:protocolHelper.newProtocolLocation.organization.humanSubAssurance,organizationName:protocolHelper.newProtocolLocation.organization.organizationName,rolodex.firstName:protocolHelper.newProtocolLocation.organization.rolodex.firstName,rolodex.lastName:protocolHelper.newProtocolLocation.organization.rolodex.lastName,rolodex.addressLine1:protocolHelper.newProtocolLocation.organization.rolodex.addressLine1,rolodex.addressLine2:protocolHelper.newProtocolLocation.organization.rolodex.addressLine2,rolodex.addressLine3:protocolHelper.newProtocolLocation.organization.rolodex.addressLine3,rolodex.city:protocolHelper.newProtocolLocation.organization.rolodex.city,rolodex.state:protocolHelper.newProtocolLocation.organization.rolodex.state))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor21').click }
  action(:)

end