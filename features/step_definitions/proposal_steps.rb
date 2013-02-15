Given /^I am logged in as admin$/ do
  @user = make UserObject
  @user.sign_in unless @user.logged_in?
end

When /^I create a proposal$/ do
  @proposal = create ProposalDevelopmentObject
end

Then /^It's created$/ do
  on(Proposal).feedback.should=='Document was successfully saved.'
end

When /^I delete the proposal$/ do
  @proposal.delete
end

Then /^The proposal is deleted$/ do
  @proposal.status.should=='CANCELED'
  @proposal.open_document
  on(Proposal).error_message.should=='The Development Proposal has been deleted.'
end

When /^I add a (Co-Investigator|Key Person|Principal Investigator) to the proposal, named (\w+) (\w+)$/ do |role, first, last|
  @proposal.add_key_personnel first_name: first, last_name: last, role: role
end