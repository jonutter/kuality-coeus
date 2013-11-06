When(/^I submit a new institutional proposal document$/) do
  @proposal_log = create ProposalLogObject
  @proposal_log.submit
  @institutional_proposal = create InstitutionalProposalObject,
                                   proposal_number: @proposal_log.number
  @institutional_proposal.add_custom_data
  @institutional_proposal.set_valid_credit_splits
  #on(InstitutionalProposal).institutional_proposal_actions
  #on(InstitutionalProposalActions).submit
end

When(/^I merge the temporary proposal log with the institutional proposal$/) do
  visit(Researcher).search_proposal_log
  on ProposalLogLookup do |page|
    page.proposal_number.set @temp_proposal_log.number
    page.search
    page.merge_item(@temp_proposal_log.number)
  end
  on InstitutionalProposalLookup do |page|
    page.institutional_proposal_number.set @institutional_proposal.proposal_number
    page.search
    page.select_item(@institutional_proposal.proposal_number)
  end
end
When(/^I merge the permanent proposal log with the institutional proposal$/) do
  pending
end