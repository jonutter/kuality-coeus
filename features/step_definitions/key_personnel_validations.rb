And /^I add (.*) as a (.*) to the key personnel proposal roles$/ do |user_name, proposal_role|
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

When /^I add a key person without a key person role$/ do
  @proposal.add_key_person role: 'Key Person', key_person_role:''
end

When /^I add a co-investigator without a unit$/ do
  @proposal.add_key_person role: 'Co-Investigator'
  @proposal.key_personnel.co_investigator.delete_units
  on(KeyPersonnel).save
end

When /^I add a key person with an invalid unit type$/ do
  @proposal.add_key_person role: 'Key Person', key_person_role: 'king', units: [{number: 'invalid'}]
end

Then /^a key personnel error should say (.*)$/ do |error|
  errors = {'at least one principal investigator is required' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
            'to select a valid unit' => 'Please select a valid Unit.',
            'a key person role is required' => 'Key Person Role is a required field.',
            'the credit split is not a valid percentage' => 'Credit Split is not a valid percentage.',
            'the co-investigator requires at least one unit' => "At least one Unit is required for #{@proposal.key_personnel.co_investigator.full_name}.",
            'only one PI is allowed' => 'Only one proposal role of Principal Investigator is allowed.'
  }
  on(KeyPersonnel).errors.should include errors[error]
end

When /^I add a principal investigator$/ do
  @proposal.add_principal_investigator
end
Then /^there should be an error that says the (.*) user already holds investigator role$/ do |role|
  on(KeyPersonnel).errors.should include "#{get(role).first_name} #{get(role).last_name} already holds Investigator role."
end