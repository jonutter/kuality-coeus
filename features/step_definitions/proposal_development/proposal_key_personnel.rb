And /^I? ?add the (.*) user as an? (.*) to the key personnel proposal roles$/ do |user_role, proposal_role|
  user = get(user_role)
  @proposal.add_key_person first_name: user.first_name, last_name: user.last_name, role: proposal_role
  @proposal.set_valid_credit_splits
end

And /adds? a key person to the Proposal$/ do
  @proposal.add_key_person role: 'Key Person', key_person_role: random_alphanums
end

When /^I? ?add (.*) as a key person with a role of (.*)$/ do |user_name, kp_role|
  user = get(user_name)
  @proposal.add_key_person first_name: user.first_name,
                           last_name: user.last_name,
                           role: 'Key Person',
                           key_person_role: kp_role
end

And /^I? ?add a (.*) with a (.*) credit split of (.*)$/ do |role, cs_type, amount|
  @proposal.add_key_person cs_type.downcase.to_sym=>amount, role: role
end

When /^I? ?try to add two principal investigators$/ do
  2.times { @proposal.add_principal_investigator }
end

When /^I? ?adds? a key person without a key person role$/ do
  @proposal.add_key_person role: 'Key Person', key_person_role:''
end

And /adds? a co-investigator to the Proposal$/ do
  @proposal.add_key_person role: 'Co-Investigator'
end

When /^I? ?add a co-investigator without a unit to the Proposal$/ do
  @proposal.add_key_person role: 'Co-Investigator'
  @proposal.key_personnel.co_investigator.delete_units
end

When /^I? ?add a key person with an invalid unit type$/ do
  @proposal.add_key_person role: 'Key Person',
                           key_person_role: 'king',
                           units: [{number: 'invalid'}]
end

Then /^a key personnel error should appear, saying the co-investigator requires at least one unit$/ do
  on(KeyPersonnel).errors.should include "At least one Unit is required for #{@proposal.key_personnel.co_investigator.full_name}."
end

When /^I? ?adds? a principal investigator to the Proposal$/ do
  @proposal.add_principal_investigator
end

Given /^I? ?add the Grants.Gov user as the Proposal's PI$/ do
  @proposal.add_principal_investigator last_name: $users.grants_gov_pi.last_name, first_name: $users.grants_gov_pi.first_name
end

When /^I? ?sets? valid credit splits for the Proposal$/ do
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

When /^the (.*) user approves the Proposal$/ do |role|
  get(role).sign_in
  @proposal.view :proposal_summary
  on(ProposalSummary).approve
  on(Confirmation).yes
end

When(/^I try to add the (.*) user as a (.*) to the key personnel Proposal roles$/) do |user_role, proposal_role|
  user = get(user_role)
  @proposal.add_key_person first_name: user.first_name, last_name: user.last_name, role: proposal_role
end