Given /^I am logged in as admin$/ do
  @user = make UserObject
  @user.sign_in unless @user.logged_in?
end

And /^I begin a proposal$/ do
  @proposal = create ProposalDevelopmentObject
end

When /^I begin a proposal without a (.*)$/ do |name|
  name=~/Type/ || name=='Lead Unit' ? value='select' : value=''
  field = StringFactory.damballa(name).to_sym
  @proposal = create ProposalDevelopmentObject, field=>value
end

Then /^I should see an error that says (.*)$/ do |error|
  on(Proposal).errors.should include error
end

