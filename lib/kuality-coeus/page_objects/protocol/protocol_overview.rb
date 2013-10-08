class ProtocolOverview < KCProtocol

  protocol_header_elements
  description_field

  # Document Overview
  element(:org_doc_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }

  # Required Fields
  element(:protocol_type) { |b| b.frm.select(name: 'document.protocolList[0].protocolTypeCode') }
  element(:title) { |b| b.frm.text_field(name: 'document.protocolList[0].title') }
  action(:pi_employee_search) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.KcPerson!!).(((personId:protocolHelper.personId,fullName:protocolHelper.principalInvestigatorName,unit.unitNumber:protocolHelper.lookupUnitNumber,unit.unitName:protocolHelper.lookupUnitName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  element(:lead_unit) { |b| b.frm.text_field(name: 'protocolHelper.leadUnitNumber') }
  action(:find_lead_unit) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Unit!!).(((unitNumber:protocolHelper.leadUnitNumber,unitName:protocolHelper.leadUnitName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor').click }
  element(:save_button) { |b| b.frm.button(name: 'methodToCall.save') }

  # Status' and Dates
  #TODO: Capture status' and dates table.

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
  action(:org_type) { |b| b.frm.select_list(name: 'protocolHelper.newProtocolLocation.protocolOrganizationTypeCode') }
  action(:org_add) { |b| b.frm.button(name: 'methodToCall.addProtocolLocation.anchorOrganizations') }
  #TODO: Create table options so that we can deal with the 'clear contact' and 'delete org' options.

  # Funding Sources
  element(:funding_type) { |b| b.frm.select_list(name: 'protocolHelper.newFundingSource.fundingSourceTypeCode') }
  element(:funding_number) { |b| b.frm.text_field(name: 'protocolHelper.newFundingSource.fundingSourceNumber') }
  action(:funding_number_lookup) { |b| b.frm.button(name: 'methodToCall.performFundingSourceLookup.(!!!!).((())).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).anchor28') }
  element(:funding_source_name) { |b| b.frm.text_field(name: 'protocolHelper.newFundingSource.fundingSourceNumber') }

  # Participant Types
  element(:participant_type) { |b| b.frm.select_list(name: 'protocolHelper.newProtocolParticipant.participantTypeCode') }
  element(:participant_count) { |b| b.frm.text_field(name: 'protocolHelper.newProtocolParticipant.participantCount') }
  action(:participant_add) { |b| b.frm.button(name: 'methodToCall.addProtocolParticipant.anchorParticipantTypes').click }
  #TODO: Create table options to maintain the partipant types and counts. Also so that counts can be updated.


end