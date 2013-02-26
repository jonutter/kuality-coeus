And /^I activate a validation check$/ do
  on(Proposal).proposal_actions
  on ProposalActions do |page|
    page.show_data_validation
    page.turn_on_validation
  end
end
When /^the proposal has no principal investigator$/ do
  # Nothing needed for this step
end
Then /^the validation error should say (.*)$/ do |error|
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.'
  }
  on(ProposalActions).validation_errors_and_warnings.should include errors[error]
end