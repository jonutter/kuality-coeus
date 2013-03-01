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
<<<<<<< HEAD
  'proposal questions were not answered' => 'Answer is required for Question 1 in group A. Proposal Questions.',
  'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.',
  'questionnaire must be completed' => %|You must complete the questionnaire "S2S FAT &amp; Flat Questionnaire"|,
  'you must complete the compliance question' => 'Answer is required for Question 1 in group B. Compliance.'}
  on(ProposalActions).validation_errors_and_warnings.should include errors[error]

end
When /^I do not answer my proposal questions$/ do
  #nothing needed for this step
end

When /^I do not complete the S2S FAT & Flat questionnaire$/ do
  #nothing necessary for this step
end
When /^I do not complete the compliance question$/ do
  #nothing necessary for this step
end
When /^I do not complete the kuali university questions$/ do
  #nothing necessary for this step
end