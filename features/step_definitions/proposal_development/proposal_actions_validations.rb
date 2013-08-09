And /^I? ?activate a validation check$/ do
  on(Proposal).proposal_actions
  on ProposalActions do |page|
    page.show_data_validation
    page.turn_on_validation
  end
end

When /^the proposal has no principal investigator$/ do
  #nothing needed for this step
end

Then /^a validation error should say (.*)$/ do |error|
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
  'proposal questions were not answered' => 'Answer is required for Question 1 in group A. Proposal Questions.',
  'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.',
  'questionnaire must be completed' => %|You must complete the questionnaire "S2S FAT &amp; Flat Questionnaire"|,
  'you must complete the compliance question' => 'Answer is required for Question 1 in group B. Compliance.',
  'the investigator needs to be certified' => 'The Investigators are not all certified. Please certify Dick  COIAdmin.',
  'the key person needs to be certified' => 'The Investigators are not all certified. Please certify Jeff  Covey.'}
  on(ProposalActions).validation_errors_and_warnings.should include errors[error]
end

Then /^one of the validation errors should say that (.*)$/ do |error|
  errors = { 'an original proposal ID is needed'=>'Please provide an original institutional proposal ID that has been previously submitted to Grants.gov for a Change\/Corrected Application.',
             'the prior award number is required'=>'require the sponsor\'s prior award number in the "sponsor proposal number."'}

  puts on(ProposalActions).validation_errors_and_warnings.inspect

  on(ProposalActions).validation_errors_and_warnings.any? { |item| item=~/#{errors[error]}/ }.should be true
end

When /^I? ?do not answer my proposal questions$/ do
  #nothing necessary for this step
end

When /^I? ?initiate a proposal with an un-certified (.*)$/ do |role|
  @role = role
  @proposal = create ProposalDevelopmentObject
  @proposal.add_key_person role: @role, certified: false
end

Given /^I? ?initiate a proposal where the un-certified key person has certification questions$/ do
  @role = 'Key Person'
  @proposal = create ProposalDevelopmentObject
  @proposal.add_key_person role: @role, key_person_role: 'default', certified: false
  on(KeyPersonnel).include_certification_questions @proposal.key_personnel.uncertified_key_person(@role).full_name
end

Then /^checking the key personnel page shows an error that says (.*)$/ do |error|
  on(ProposalActions).key_personnel
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.'
  }
  on(KeyPersonnel).errors.should include errors[error]
end

Then /^checking the proposal page shows an error that says (.*)$/ do |error|
  on(ProposalActions).proposal
  errors = {'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.'
  }
  on(Proposal).errors.should include errors[error]
end

Then /^checking the questions page shows an error that says (.*)$/ do |error|
  on(Proposal).questions
  errors = {'proposal questions were not answered' => 'Answer is required for Question 1 in group A. Proposal Questions.',
            'questionnaire must be completed' => %|You must complete the questionnaire "S2S FAT & Flat Questionnaire"|,
            'you must complete the compliance question' => 'Answer is required for Question 1 in group B. Compliance.'
  }
  on(Questions).errors.should include errors[error]
end

Then /^checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified$/ do
  on(ProposalActions).key_personnel
  on(KeyPersonnel).errors.should include "The Investigators are not all certified. Please certify #{@proposal.key_personnel.uncertified_person(@role).full_name}."
end