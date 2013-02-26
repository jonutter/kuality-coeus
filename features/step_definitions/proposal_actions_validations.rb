And /^I activate a validation check$/ do
  on(Proposal).proposal_actions
  on(ProposalActions).show_data_validation
  on(ProposalActions).turn_on_validation
end
Then /^I should see a key personal information error$/ do
  on(ProposalActions).show_key_personnel_errors

end