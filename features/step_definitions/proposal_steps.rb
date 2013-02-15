Given /^I am logged in as admin$/ do
  @user = make UserObject
  @user.sign_in
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