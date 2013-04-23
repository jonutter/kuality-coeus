When /^I visit the proposal's (.*) page$/ do |page|
  # Ensure we're where we need to be in the system...
  @proposal.open_document
  # Be sure that the page name used in the scenario
  # will be converted to the snake case value of
  # the method that clicks on the proposal's page tab.
  on(Proposal).send(StringFactory.damballa(page))
end

Then /^(.*) is listed as (a|an) (.*) for the proposal$/ do |username, x, role|
  on(Permissions).assigned_role(get(username).user_name).should include role
end

When /^I assign (.*) as (a|an) (.*) to the proposal permissions$/ do |username, x, role|
  set(username, (make UserObject, user: username))
  @proposal.permissions.send(StringFactory.damballa(role+'s')) << username
  @proposal.permissions.assign
end

Then /^(.*) can access the proposal$/ do |username|
  get(username).sign_in
  @proposal.open_document
end

When /^can (.*)$/ do |permissions|
  case permissions
    when 'only update the Abstracts and Attachments page'

    when 'edit all parts of the proposal'

    when 'only update the budget'

    when 'only read the proposal'

    when 'delete the proposal'

    when 'approve the proposal'

  end
end