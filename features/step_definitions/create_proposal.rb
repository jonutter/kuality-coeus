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
  text=~/Description/ ? error='Document '+text : error=text
  on(Proposal) do |page|
    page.error_summary.wait_until_present(5)
    page.errors.should include error
  end
end
<<<<<<< HEAD
When /^I begin a proposal with an invalid sponsor code$/ do
  @proposal = create ProposalDevelopmentObject, :sponsor_code=>'000000'
end
Then /^I should see an error that says valid sponsor code required$/ do
  on(Proposal).errors.should include 'A valid Sponsor Code (Sponsor) must be selected.'
=======

And /^I add (.*) (.*) as a (.*) to Key Personnel$/ do |fname, lname, proposal_role|
  @proposal.add_key_personnel first_name: fname, last_name: lname, role: proposal_role
end

And /^I add (.*) (.*) as a Key Person with a role of (.*)$/ do |fname, lname, kp_role|
  @proposal.add_key_personnel first_name: fname, last_name: lname, role: 'Key Person', key_person_role: kp_role
>>>>>>> b425ca5e3c793e28f35df452c4996d6f271af5a2
end