And /^I activate a validation check$/ do
  on(Proposal).proposal_actions
  on(ProposalActions).turn_on_validation
end
Then /^I should see a key personal information error$/ do
  pending
end