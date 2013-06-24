class Distribution < KCInstitutionalProposal

  inst_prop_header_elements

  element(:add_cost_share_project_period) { |b| b.frm.text_field(name: 'institutionalProposalCostShareBean.newInstitutionalProposalCostShare.projectPeriod') }
  element(:add_cost_share_type) { |b| b.frm.select(name: 'institutionalProposalCostShareBean.newInstitutionalProposalCostShare.costShareTypeCode') }
  element(:add_cost_share_percentage) { |b| b.frm.text_field(name: 'institutionalProposalCostShareBean.newInstitutionalProposalCostShare.costSharePercentage') }
  element(:add_cost_share_source_account) { |b| b.frm.text_field(name: 'institutionalProposalCostShareBean.newInstitutionalProposalCostShare.sourceAccount') }
  element(:add_cost_share_amount) { |b| b.frm.text_field(name: 'institutionalProposalCostShareBean.newInstitutionalProposalCostShare.amount') }
  action(:add_cost_share) { |b| b.frm.button(name: 'methodToCall.addCostShare.anchorCostSharing').click; b.loading }

  element(:add_unrec_f_a_fiscal_year) { |b| b.frm.text_field(name: 'institutionalProposalUnrecoveredFandABean.newInstitutionalProposalUnrecoveredFandA.fiscalYear') }
  element(:add_rate_type) { |b| b.frm.select(name: 'institutionalProposalUnrecoveredFandABean.newInstitutionalProposalUnrecoveredFandA.indirectcostRateTypeCode') }
  element(:add_fa_applicable_rate) { |b| b.frm.text_field(name: 'institutionalProposalUnrecoveredFandABean.newInstitutionalProposalUnrecoveredFandA.applicableIndirectcostRate') }
  element(:add_fa_campus_flag) { |b| b.frm.checkbox(name: 'institutionalProposalUnrecoveredFandABean.newInstitutionalProposalUnrecoveredFandA.onCampusFlag') }
  element(:add_fa_source_account) { |b| b.frm.text_field(name: 'institutionalProposalUnrecoveredFandABean.newInstitutionalProposalUnrecoveredFandA.sourceAccount') }
  element(:add_fa_amount) { |b| b.frm.text_field(name: 'institutionalProposalUnrecoveredFandABean.newInstitutionalProposalUnrecoveredFandA.underrecoveryOfIndirectcost') }
  action(:add_unrecovered_f_a) { |b| b.frm.button(name: 'methodToCall.addUnrecoveredFandA.anchorUnrecoveredFA').click; b.loading }

end