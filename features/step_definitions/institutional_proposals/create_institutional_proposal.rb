When(/^I initiate a new institutional proposal document$/) do
  @proposal_log = create ProposalLogObject
  @proposal_log.submit
  @institutional_proposal = create InstitutionalProposalObject,
                                   proposal_number: @proposal_log.number
  sleep 10
end
When(/^I merge the temporary proposal log with the institutional proposal$/) do
  pending
end
When(/^I merge the permanent proposal log with the institutional proposal$/) do
  pending
end