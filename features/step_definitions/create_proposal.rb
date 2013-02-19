Given /^I am logged in as admin$/ do
  @user = make UserObject
  @user.sign_in
end

And /^I create a proposal$/ do
  on(Researcher).create_proposal
  on Proposal do |create|
end
When /^I validate my proposal$/ do
  pending
end
Then /^I see an error that says There is no Principal Investigator selected. Please enter a Principal Investigator.$/ do
  pending
end
