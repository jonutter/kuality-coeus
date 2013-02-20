And /^I activate a validation check$/ do
  on(ProposalDevelopmentObject).
  on ProposalActions.turn_on_validation.click
end
Then /^I should see a key personal information error$/ do
  pending
end