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
  on(Researcher).error_table.should_not be_present
end

Then /^the proposal is in (.*)'s action list$/ do |username|
  get(username).sign_in
  visit(ActionList).item(@proposal.document_id).should exist
end

And /^their proposal permissions allow them to (.*)$/ do |permissions|
  case permissions
    when 'only update the Abstracts and Attachments page'
      on(Proposal).abstracts_and_attachments
      @proposal.close
      on(QuestionDialogPage).yes

    when 'edit all parts of the proposal'
      on(Proposal).save_button.should be_present
      on(AbstractsAndAttachments).save_button.should be_present
      on(CustomData).save_button.should be_present
      on(KeyPersonnel).save_button.should be_present
#      on(Permissions).save_button.should be_present
      on(ProposalActions).save_button.should be_present
      on(Questions).save_button.should be_present
      on(SpecialReview).save_button.should be_present

    when 'only update the budget'
      on(Proposal).budget_versions
      @proposal.close
      on(QuestionDialogPage).yes

    when 'only read the proposal'

    when 'delete the proposal'
      on(Proposal).proposal_actions
      @proposal.delete_proposal
      on(QuestionDialogPage).yes

  end
end
