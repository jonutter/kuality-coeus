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

Then /^I should see an error that says "(.* is a required field.)"$/ do |text|
  text=~/Description/ ? error='Document Description is a required field.' : error=text
  on(Proposal) do |page|
    page.error_summary.wait_until_present(5)
    page.errors.should include error
  end
end