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
  'the investigator needs to be certified' => 'The Investigators are not all certified. Please certify Dick  COIAdmin.',
  'the key person needs to be certified' => 'The Investigators are not all certified. Please certify Jeff  Covey.'}
  on(ProposalActions).validation_errors_and_warnings.should include errors[error]
end

When /^I do not answer my proposal questions$/ do
  #nothing necessary for this step
end

When /^I do not complete the S2S FAT & Flat questionnaire$/ do
  #nothing necessary for this step
end

When /^I do not complete the compliance question$/ do
  #nothing necessary for this step
end

When /^I do not complete the kuali university questions$/ do
  # Here we're going to answer a random selection of all but one
  # of the questions required in the questionnaire.
  # The questions...
  questions=[:dual_dept_appointment, :on_sabbatical, :used_by_small_biz, :understand_deadline]
  # The answers...
  answers=%w{Y N}
  # Set them up, answering all questions but one, and pass
  # the resulting options to the proposal object...
  opts={}
  questions.shuffle.each_with_index { |question, index| opts.store(question, (index==3 ? nil : answers.sample)) }
  puts opts.inspect # some debug code
  @proposal.answer_kuali_u_questions opts
end

When /^I begin a proposal with an un-certified co-investigator$/ do
  @proposal = create ProposalDevelopmentObject
  on(Proposal).key_personnel
  @proposal.add_key_person first_name: 'Dick', last_name: 'COIAdmin', role: 'Co-Investigator', certified: false
end

And /^checking the key personnel page shows an error that says (.*)$/ do |error|
  on(ProposalActions).key_personnel
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
  'the investigator needs to be certified' => "The Investigators are not all certified. Please certify #{@proposal.key_personnel.uncertified_person('Co-Investigator').full_name}."
  }
  on(KeyPersonnel).errors.should include errors[error]
end

When /^checking the proposal page shows an error that says (.*)$/ do |error|
  on(ProposalActions).proposal
  errors = {'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.'
  }
  on(Proposal).errors.should include errors[error]
end

When /^checking the questions page shows an error that says (.*)$/ do |error|
  on(Proposal).questions
  errors = {'proposal questions were not answered' => 'Answer is required for Question 1 in group A. Proposal Questions.'
  }
  on(Questions).errors.should include errors[error]
end

Given /^I begin a proposal with an uncertified key person but add the certification questions$/ do
  @proposal = create ProposalDevelopmentObject
  @proposal.add_key_person first_name: 'Jeff', last_name: 'Covey', role: 'Key Person', key_person_role: 'default', certified: false
  on(KeyPersonnel).include_certification_questions @proposal.key_personnel.uncertified_key_person.full_name
end

When /^checking the key personnel page shows a proposal person certification error that says the key person needs to be certified$/ do
  on(ProposalActions).key_personnel
  on(KeyPersonnel).errors.should include "The Investigators are not all certified. Please certify #{@proposal.key_personnel.uncertified_person('Key Person').full_name}."
end
Given /^I begin a proposal with an uncertified pricipal investigator$/ do
  @proposal = create ProposalDevelopmentObject
  on(Proposal).key_personnel
  @proposal.add_key_person first_name:'Dick', last_name:'Covey', role:'Principal Investigator', certified: false
end