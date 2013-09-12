class AwardLookup < Lookups

  element(:award_id) { |b| b.frm.text_field(name: 'awardNumber') }
  element(:sponsor_award_id) { |b| b.frm.text_field(name: 'sponsorAwardNumber') }
  element(:account_id) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:award_status) { |b| b.frm.select(name: 'statusCode') }
  action(:award_status_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.award.home.AwardStatus!!).(((statusCode:statusCode))).((`statusCode:statusCode`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  element(:sponsor_id) { |b| b.frm.text_field(name: 'sponsorCode') }
  action(:sponsor_id_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Sponsor!!).(((sponsorCode:sponsorCode))).((`sponsorCode:sponsorCode`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  element(:award_title) { |b| b.frm.text_field(name: 'title') }
  element(:investigator) { |b| b.frm.text_field(name: 'projectPersons.fullName') }
  element(:lead_id_unit) { |b| b.frm.text_field(name: 'unitNumber') }
  element(:lead_unit_name) { |b| b.frm.button(name: 'leadUnit.unitName') }
  action(:lead_unit_id_lookup) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.kra.bo.Unit!!).(((unitNumber:unitNumber))).((`unitNumber:unitNumber`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  alias_method :lead_unit_name_lookup
  element(:osp_administrator) { |b| b.frm.text_field(name: 'lookupOspAdministratorName') }
  element(:archive_location) { |b| b.frm.text_field(name: 'archiveLocation') }
  element(:archive_date_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_closeoutDate') }
  element(:archive_date_to) { |b| b.frm.text_field(name: 'closeoutDate') }

end