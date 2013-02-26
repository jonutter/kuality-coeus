And /^I activate a validation check$/ do
  on(Proposal).proposal_actions
  on(ProposalActions).show_data_validation
  on(ProposalActions).turn_on_validation
end
When /^the proposal has no principal investigator$/ do
  #nothing needed for this step
end
Then /^the validation error should say (.*)$/ do |error|
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.'
  }
  on(ProposalActions).validation_errors_and_warnings.should include errors[error]
end