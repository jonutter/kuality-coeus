class S2S < ProposalDevelopmentDocument

  proposal_header_elements

  element(:s2s_header) { |b| b.frm.h2(text: 'S2S') }
  action(:s2s_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.s2s.bo.S2sOpportunity!!).(((opportunityId:newS2sOpportunity.opportunityId,cfdaNumber:newS2sOpportunity.cfdaNumber,opportunityTitle:newS2sOpportunity.opportunityTitle,s2sSubmissionTypeCode:newS2sOpportunity.s2sSubmissionTypeCode,revisionCode:newS2sOpportunity.revisionCode,competetionId:newS2sOpportunity.competetionId,openingDate:newS2sOpportunity.openingDate,closingDate:newS2sOpportunity.closingDate,instructionUrl:newS2sOpportunity.instructionUrl,schemaUrl:newS2sOpportunity.schemaUrl,providerCode:newS2sOpportunity.providerCode))).((`document.developmentProposalList[0].programAnnouncementNumber:opportunityId,document.developmentProposalList[0].cfdaNumber:cfdaNumber,document.developmentProposalList[0].s2sOpportunity.providerCode:providerCode`)).((<>)).(([])).((**)).((^^)).((&yes&)).((//)).((~no~)).(::::;;::::).anchor').click }

end