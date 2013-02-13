Given /^I am logged in as admin$/ do
  @user = make UserObject
  @user.sign_in
end
When /^I create a proposal$/ do
  @proposal = create ProposalDevelopmentObject
  #@goo = create PermissionsObject, document_id: "4255"
  p @proposal.permissions.roles
end
Then /^It's created$/ do
  sleep 15
  on(Proposal).feedback.should=='Document was successfully saved.'
end