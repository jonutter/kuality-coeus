class Commitments < KCAwards

  award_header_elements
  error_messages

  element(:new_cost_sharing_percentage) { |b| b.frm.text_field(name: 'costShareFormHelper.newAwardCostShare.costSharePercentage') }
  element(:new_cost_sharing_type) { |b| b.frm.select(name: 'costShareFormHelper.newAwardCostShare.costShareTypeCode') }
  element(:new_cost_sharing_project_period) { |b| b.frm.text_field(name: 'costShareFormHelper.newAwardCostShare.projectPeriod') }
  element(:new_cost_sharing_commitment_amount) { |b| b.frm.text_field(name: 'costShareFormHelper.newAwardCostShare.commitmentAmount') }
  action(:add_cost_sharing) { |b| b.frm.button(name: 'methodToCall.addCostShare.anchor').click; b.loading }
  
  element(:new_rate) { |b| b.frm.text_field(name: 'newAwardFandaRate.applicableFandaRate') }
  element(:new_rate_type) { |b| b.frm.select(name: 'newAwardFandaRate.fandaRateTypeCode') }
  element(:new_rate_fiscal_year) { |b| b.frm.text_field(name: 'newAwardFandaRate.fiscalYear') }
  element(:new_rate_start_date) { |b| b.frm.text_field(name: 'newAwardFandaRate.startDate') }
  element(:new_rate_campus) { |b| b.frm.select(name: 'newAwardFandaRate.onCampusFlag') }
  action(:add_rate) { |b| b.frm.button(name: 'methodToCall.addFandaRate.anchorRates').click; b.loading }
  
  element(:on_campus) { |b| b.frm.text_field(name: 'document.awardList[0].specialEbRateOnCampus') }
  element(:off_campus) { |b| b.frm.text_field(name: 'document.awardList[0].specialEbRateOffCampus') }
  
  element(:sponsor_authorized_amount) { |b| b.frm.text_field(name: 'document.awardList[0].preAwardAuthorizedAmount') }
  element(:sponsor_effective_date) { |b| b.frm.text_field(name: 'document.awardList[0].preAwardEffectiveDate') }
  element(:institutional_authorized_amount) { |b| b.frm.text_field(name: 'document.awardList[0].preAwardInstitutionalAuthorizedAmount') }
  element(:institutional_effective_date) { |b| b.frm.text_field(name: 'document.awardList[0].preAwardInstitutionalEffectiveDate') }
  
end