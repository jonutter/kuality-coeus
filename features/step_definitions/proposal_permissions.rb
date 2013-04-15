When /^I visit the proposal's (.*) page$/ do |page|
  # Ensure we're where we need to be in the system...
  @proposal.open_document
  # Be sure that the page name used in the scenario
  # will be converted to the snake case value of
  # the method that clicks on the proposal's page tab.
  on(Proposal).send(StringFactory.damballa(page))
end

Then /^I am listed as (a|an) (.*) for the proposal$/ do |x, role|
  on(Permissions).assigned_role(@user.user_name).should include role
end

