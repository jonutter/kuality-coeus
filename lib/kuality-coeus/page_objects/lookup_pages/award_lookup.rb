class AwardLookup < Lookups

  element(:award_id) { |b| b.frm.text_field(name: 'awardNumber') }
  element(:sponsor_award_id) { |b| b.frm.text_field(name: 'sponsorAwardNumber') }
  element(:account_id) { |b| b.frm.text_field(name: 'accountNumber') }
  element(:award_status) { |b| b.frm.select(name: 'statusCode') }
  element(:sponsor_id) { |b| b.frm.text_field(name: 'sponsorCode') }
  element(:award_title) { |b| b.frm.text_field(name: 'title') }
  element(:investigator) { |b| b.frm.text_field(name: 'projectPersons.fullName') }
  element(:osp_administrator) { |b| b.frm.text_field(name: 'lookupOspAdministratorName') }

end