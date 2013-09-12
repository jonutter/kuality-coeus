class InstitutionalProposalLookup < Lookup

  element(:institutional_proposal_number) { |b| b.frm.text_field(name: 'proposalNumber') }
  element(:institutional_proposal_type) { |b| b.frm.select(name: 'proposalTypeCode') }
  action(:institutional_proposal_type_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.proposaldevelopment.bo.ProposalType!!).(((proposalTypeCode:proposalTypeCode))).((`proposalTypeCode:proposalTypeCode`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  element(:institutional_proposal_status) { |b| b.frm.select(name: 'statusCode') }
  action(:insitutional_proposal_status_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.institutionalproposal.ProposalStatus!!).(((proposalStatusCode:statusCode))).((`statusCode:proposalStatusCode`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  element(:account_id) { |b| b.frm.text_field(name: 'currentAccountNumber') }
  element(:project_title) { |b| b.frm.text_field(name: 'title') }
  element(:unit_id) { |b| b.frm.text_field(name: 'lookupUnit.unitNumber') }
  action(:unit_id_lookup) { |b| b.frm.button(name 'methodToCall.performLookup.(!!org.kuali.kra.bo.Unit!!).(((unitNumber:lookupUnit.unitNumber))).((`lookupUnit.unitNumber:unitNumber`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  element(:unit_name) { |b| b.frm.text_field(name: 'lookupUnit.unitName') }
  element(:proposal_person) { |b| b.frm.text_field(name: 'projectPersons.fullName') }
  action(:proposal_person_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.institutionalproposal.contacts.InstitutionalProposalPerson!!).(((fullName:projectPersons.fullName))).((`projectPersons.fullName:fullName`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  element(:sponsor_id) { |b| b.frm.text_field(name: 'sponsorCode') }
  action(:sponsor_id_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Sponsor!!).(((sponsorCode:sponsorCode))).((`sponsorCode:sponsorCode`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  element(:sponsor_name) { |b| b.frm.button(name: 'sponsor.sponsorName') }

end