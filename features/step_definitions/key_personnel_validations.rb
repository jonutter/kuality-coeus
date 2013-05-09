And /^I add (.*) as a (.*) to Key Personnel$/ do |user_name, proposal_role|
  user = get(user_name)
  @proposal.add_key_person first_name: user.first_name, last_name: user.last_name, role: proposal_role
end

When /^I add (.*) as a Key Person with a role of (.*)$/ do |user_name, kp_role|
  user = get(user_name)
  @proposal.add_key_person first_name: user.first_name, last_name: user.last_name, role: 'Key Person', key_person_role: kp_role
end

And /^I add a (.*) with a (.*) credit split of (.*)$/ do |role, cs_type, amount|
  @proposal.add_key_person cs_type.downcase.to_sym=>amount, role: role
end

When /^I try to add two Principal Investigators$/ do
  2.times { @proposal.add_principal_investigator }
end

Then /^I should see an error that the credit split is not a valid percentage$/ do
  on(KeyPersonnel).errors.should include 'Credit Split is not a valid percentage.'
end

When /^I add a key person without a key person role$/ do
  @proposal.add_key_person role: 'Key Person', key_person_role:''
end

Then /^I should see an error that says proposal role is required$/ do
  on(KeyPersonnel).errors.should include 'Key Person Role is a required field.'
end

When /^I add a co-investigator without a unit$/ do
  @proposal.add_key_person role: 'Co-Investigator'
  @proposal.key_personnel.co_investigator.delete_units
  on(KeyPersonnel).save
end

Then /^I should see a key personnel error that says at least one unit is required$/ do
  on(KeyPersonnel).errors.should include "At least one Unit is required for #{@proposal.key_personnel.co_investigator.full_name}."
end

Then /^I should see an error that says only one pi role is allowed$/ do
  on(KeyPersonnel).errors.should include 'Only one proposal role of Principal Investigator is allowed.'
end

When /^I add a key person with an invalid unit type$/ do
  @proposal.add_key_person role: 'Key Person', key_person_role: 'king', units: [{number: 'invalid'}]
end

Then /^I should see an error that says please select a valid unit$/ do
  on(KeyPersonnel).errors.should include 'Please select a valid Unit.'
end

Then /^the key personnel error should say (.*)$/ do |error|
  errors = {'at least one principal investigator is required' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.'
  }
  on(KeyPersonnel).errors.should include errors[error]
end

When /^I add a principal investigator$/ do
  @proposal.add_principal_investigator
end