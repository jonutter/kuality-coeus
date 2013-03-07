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
  'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.',
  'questionnaire must be completed' => %|You must complete the questionnaire "S2S FAT &amp; Flat Questionnaire"|,
  'you must complete the compliance question' => 'Answer is required for Question 1 in group B. Compliance.',
  'the investigator needs to be certified' => 'The Investigators are not all certified. Please certify Dick  COIAdmin.'}
  on(ProposalActions).validation_errors_and_warnings.should include errors[error]
end

When /^I do not answer my proposal questions$/ do
  on(Proposal).questions
  on(Questions)
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

When /^I add a co-investigator without certifying him$/ do
  @proposal.add_key_person first_name: 'Dick', last_name: 'COIAdmin', role: 'Co-Investigator', certified: false
end

And /^checking the key personnel page shows an error that says (.*)$/ do |error|
  on(ProposalActions).key_personnel
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.'
  }
  on(KeyPersonnel).errors.should include errors[error]
end

When /^checking the proposal page shows an error that says (.*)$/ do |error|
  on(ProposalActions).proposal
  errors = {'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.'
  }
  on(Proposal).required_fields_errors.should include errors[error]
end

When /^checking the questions page shows an error that says (.*)$/ do |error|
  on(Proposal).questions
  errors = {'questionnaire must be completed' => ''}
  on(Questions).x # Create page objs for errors on Questions page
end