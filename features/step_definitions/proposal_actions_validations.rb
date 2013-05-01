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

When /^I do not answer one of the kuali university questions$/ do
  # Here we're going to answer a random selection of all but one
  # of the questions required in the questionnaire.
  # The questions...
  questions=[:dual_dept_appointment, :on_sabbatical, :used_by_small_biz, :understand_deadline]
  # The answers...
  answers=%w{Y N}
  # Set them up, answering all questions but one, and pass
  # the resulting options to the proposal object...
  opts={document_id: @proposal.document_id}
  questions.shuffle.each_with_index { |question, index| opts.store(question, (index==3 ? nil : answers.sample)) }
  opts[:dual_dept_appointment]=='Y' ? opts.store(:dual_dept_explanation, random_alphanums) : opts
  # Keep the unanswered question handy for the validation step.
  @unanswered_question=opts.collect { |k,v| v==nil ? k : nil }.compact[0]
  @proposal.kuali_u_questions = create KualiUniversityQuestionsObject, opts
end

Then /^the validation should report the question was not answered$/ do
  #TODO: Figure out a better spot to put this, since it's used in multiple places...
  questions={
      :dual_dept_appointment=>1,
      :on_sabbatical=>2,
      :used_by_small_biz=>3,
      :understand_deadline=>4
  }
  on(ProposalActions).validation_errors_and_warnings.should include "Answer is required for Question #{questions[@unanswered_question]} in group C. Kuali University."
end

When /^I initiate a proposal with an un-certified (.*)$/ do |role|
  @role = role
  @proposal = create ProposalDevelopmentObject
  on(Proposal).key_personnel
  @proposal.add_key_person first_name: 'Dick', last_name: 'COIAdmin', role: @role, certified: false
end

Given /^I initiate a proposal where the un-certified key person has certification questions$/ do
  @role = 'Key Person'
  @proposal = create ProposalDevelopmentObject
  @proposal.add_key_person first_name: 'Jeff', last_name: 'Covey', role: @role, key_person_role: 'default', certified: false
  on(KeyPersonnel).include_certification_questions @proposal.key_personnel.uncertified_key_person(@role).full_name
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
  on(Proposal).errors.should include errors[error]
end

And /^checking the questions page shows an error that says (.*)$/ do |error|
  on(Proposal).questions
  errors = {'proposal questions were not answered' => 'Answer is required for Question 1 in group A. Proposal Questions.',
            'questionnaire must be completed' => %|You must complete the questionnaire "S2S FAT & Flat Questionnaire"|,
            'you must complete the compliance question' => 'Answer is required for Question 1 in group B. Compliance.'
  }
  on(Questions).errors.should include errors[error]
end

When /^checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified$/ do
  on(ProposalActions).key_personnel
  on(KeyPersonnel).errors.should include "The Investigators are not all certified. Please certify #{@proposal.key_personnel.uncertified_person(@role).full_name}."
end

When /^checking the questions page should show the question was not answered$/ do
  on(Proposal).questions
  #TODO: Figure out a better spot to put this, since it's used in multiple places...
  questions={
      :dual_dept_appointment=>1,
      :on_sabbatical=>2,
      :used_by_small_biz=>3,
      :understand_deadline=>4
  }
  on(Questions).errors.should include "Answer is required for Question #{questions[@unanswered_question]} in group C. Kuali University."
end