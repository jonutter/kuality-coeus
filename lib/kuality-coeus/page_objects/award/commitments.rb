class Commitments < KCAwards

  # Cost Sharing
  element(:new_cost_sharing_percentage) { |b| b.frm.text_field(name: 'costShareFormHelper.newAwardCostShare.costSharePercentage') }
  element(:new_cost_sharing_type) { |b| b.frm.select(name: 'costShareFormHelper.newAwardCostShare.costShareTypeCode') }
  element(:new_cost_sharing_project_period) { |b| b.frm.text_field(name: 'costShareFormHelper.newAwardCostShare.projectPeriod') }
  element(:new_cost_sharing_commitment_amount) { |b| b.frm.text_field(name: 'costShareFormHelper.newAwardCostShare.commitmentAmount') }
  action(:add_cost_sharing) { |b| b.frm.button(name: 'methodToCall.addCostShare.anchor').click; b.loading }

  p_element(:cost_sharing_percentage) { |index, b| b.frm.text_field(name: "document.awardList[0].awardCostShares[#{index}].costSharePercentage") }
  p_element(:cost_sharing_source) { |index, b| b.frm.text_field(name: "document.awardList[0].awardCostShares[#{index}].source") }
  p_element(:cost_sharing_commitment_amount) { |index, b| b.frm.text_field(name: "document.awardList[0].awardCostShares[#{index}].commitmentAmount") }

  element(:cost_sharing_comments) { |b| b.frm.text_field(name: 'document.awardList[0].awardCostShareComment.comments') }

  action(:recalculate) { |b| b.frm.button(name: 'methodToCall.recalculateCostShareTotal.anchor').click }
  action(:sync_to_template) { |b| b.frm.button(name: 'methodToCall.syncAwardTemplate.scopes:COST_SHARE.anchor').click }

  # Rates
  element(:new_rate) { |b| b.frm.text_field(name: 'newAwardFandaRate.applicableFandaRate') }
  element(:new_rate_type) { |b| b.frm.select(name: 'newAwardFandaRate.fandaRateTypeCode') }
  element(:new_rate_fiscal_year) { |b| b.frm.text_field(name: 'newAwardFandaRate.fiscalYear') }
  element(:new_rate_start_date) { |b| b.frm.text_field(name: 'newAwardFandaRate.startDate') }
  element(:new_rate_campus) { |b| b.frm.select(name: 'newAwardFandaRate.onCampusFlag') }
  action(:add_rate) { |b| b.frm.button(name: 'methodToCall.addFandaRate.anchorRates').click; b.loading }

  p_element(:fna_rate) { |index, b| b.frm.text_field(name: /document.awardList\[0\].awardFandaRate\[#{index}\].applicableFandaRate/) }
  p_element(:fna_type) { |index, b| b.frm.select(name: /document.awardList\[0\].awardFandaRate\[#{index}\].fandaRateTypeCode/) }
  p_element(:fna_fiscal_year) { |index, b| b.frm.text_field(name: /document.awardList\[0\].awardFandaRate\[#{index}\].fiscalYear/) }
  p_element(:fna_start_date) { |index, b| b.frm.text_field(name: /document.awardList\[0\].awardFandaRate\[#{index}\].startDate/) }
  p_element(:fna_end_date) { |index, b| b.frm.text_field(name: /document.awardList\[0\].awardFandaRate\[#{index}\].endDate/) }
  p_element(:fna_campus) { |index, b| b.frm.select(name: /document.awardList\[0\].awardFandaRate\[#{index}\].onCampusFlag/) }
  p_element(:fna_source) { |index, b| b.frm.text_field(name: /document.awardList\[0\].awardFandaRate\[#{index}\].sourceAccount/) }
  p_element(:fna_destination) { |index,b| b.frm.text_field(name: /document.awardList\[0\].awardFandaRate\[#{index}\].destinationAccount/) }
  p_element(:fna_amount) { |index,b| b.frm.text_field(name: /document.awardList\[0\].awardFandaRate\[#{index}\].underrecoveryOfIndirectCost/) }

  value(:fna_sources) { |b| b.noko.div(id: 'tab-Rates:FARates-div').text_fields(title: 'Source').collect{ |field| field.value }[1..-1] }
  value(:unrecovered_fna_total) { |b| b.fa_rates_table.trs[-2].td(index: 1).text }

  # Benefits Rates
  element(:on_campus) { |b| b.frm.text_field(name: 'document.awardList[0].specialEbRateOnCampus') }
  element(:off_campus) { |b| b.frm.text_field(name: 'document.awardList[0].specialEbRateOffCampus') }
  
  # Preaward Authorizations
  element(:sponsor_authorized_amount) { |b| b.frm.text_field(name: 'document.awardList[0].preAwardAuthorizedAmount') }
  element(:sponsor_effective_date) { |b| b.frm.text_field(name: 'document.awardList[0].preAwardEffectiveDate') }
  element(:institutional_authorized_amount) { |b| b.frm.text_field(name: 'document.awardList[0].preAwardInstitutionalAuthorizedAmount') }
  element(:institutional_effective_date) { |b| b.frm.text_field(name: 'document.awardList[0].preAwardInstitutionalEffectiveDate') }

  private
  
  element(:cost_sharing_table) { |b| b.frm.table(id: 'cost-share-table') }
  element(:fa_rates_table) { |b| b.frm.div(id: 'tab-Rates:FARates-div').table }
  
end