And /^I? ?add the (.*) user as an? (.*) to the key personnel proposal roles$/ do |user_role, proposal_role|
  user = get(user_role)
  @proposal.add_key_person first_name: user.first_name, last_name: user.last_name, role: proposal_role
  @proposal.set_valid_credit_splits
end

When /^I? ?add (.*) as a Key Person with a role of (.*)$/ do |user_name, kp_role|
  user = get(user_name)
  @proposal.add_key_person first_name: user.first_name, last_name: user.last_name, role: 'Key Person', key_person_role: kp_role
end

And /^I? ?add a (.*) with a (.*) credit split of (.*)$/ do |role, cs_type, amount|
  @proposal.add_key_person cs_type.downcase.to_sym=>amount, role: role
end

When /^I? ?try to add two Principal Investigators$/ do
  2.times { @proposal.add_principal_investigator }
end

When /^I? ?add a key person without a key person role$/ do
  @proposal.add_key_person role: 'Key Person', key_person_role:''
end

When /^I? ?add a co-investigator without a unit$/ do
  @proposal.add_key_person role: 'Co-Investigator'
  @proposal.key_personnel.co_investigator.delete_units
  on(KeyPersonnel).save
end

When /^I? ?add a key person with an invalid unit type$/ do
  @proposal.add_key_person role: 'Key Person', key_person_role: 'king', units: [{number: 'invalid'}]
end

Then /^a key personnel error should say (.*)$/ do |error|
  errors = {'at least one principal investigator is required' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
            'to select a valid unit' => 'Please select a valid Unit.',
            'a key person role is required' => 'Key Person Role is a required field.',
            'the credit split is not a valid percentage' => 'Credit Split is not a valid percentage.',
            'only one PI is allowed' => 'Only one proposal role of Principal Investigator is allowed.'
  }
  on(KeyPersonnel).errors.should include errors[error]
end

Then /^a key personnel error should appear, saying the co-investigator requires at least one unit$/ do
  on(KeyPersonnel).errors.should include "At least one Unit is required for #{@proposal.key_personnel.co_investigator.full_name}."
end

When /^I? ?add a principal investigator$/ do
  @proposal.add_principal_investigator
end

Given /^I? ?add the Grants.Gov user as the proposal's PI$/ do
  @proposal.add_principal_investigator last_name: @grants_gov_pi.last_name, first_name: @grants_gov_pi.first_name
end

When /^I? ?set valid credit splits for the proposal$/ do
  @proposal.set_valid_credit_splits
end

Then /^there should be an error that says the (.*) user already holds investigator role$/ do |role|
  on(KeyPersonnel).errors.should include "#{get(role).first_name} #{get(role).last_name} already holds Investigator role."
end

And(/^the (.*) button appears on the Proposal Summary and Proposal Action pages$/) do |action|
  button = "#{action.downcase}_button".to_sym
  on ProposalSummary do |page|
    page.send(button).should exist
    page.proposal_actions
  end
  on(ProposalActions).send(button).should exist
end

When /^the (.*) user approves the proposal$/ do |role|
  get(role).sign_in
  @proposal.open_proposal


sleep 20


  on(ProposalSummary).approve
  on(Confirmation).yes
end