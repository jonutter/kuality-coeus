And /^I activate a validation check$/ do
  on(Proposal).proposal_actions
  on ProposalActions do |page|
    page.show_data_validation
    page.turn_on_validation
  end
end
When /^the proposal has no principal investigator$/ do
  #nothing needed for this step
end
Then /^the validation error should say (.*)$/ do |error|
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
  'proposal questions were not answered' => 'Answer is required for Question 1 in group A. Proposal Questions.',
  'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.'
  }
  on(ProposalActions).validation_errors_and_warnings.should include errors[error]
end
When /^I do not answer my proposal questions$/ do
  #nothing needed for this step
end
When /^I begin a proposal with no sponsor deadline date$/ do
  @proposal = create ProposalDevelopmentObject
end