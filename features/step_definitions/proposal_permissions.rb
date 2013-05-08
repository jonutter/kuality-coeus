When /^I visit the proposal's (.*) page$/ do |page|
  # Ensure we're where we need to be in the system...
  @proposal.open_document
  # Be sure that the page name used in the scenario
  # will be converted to the snake case value of
  # the method that clicks on the proposal's page tab.
  on(Proposal).send(snake_case(page))
end

Then /^(.*) is listed as (a|an) (.*) for the proposal$/ do |username, x, role|
  on(Permissions).assigned_role(get(username).user_name).should include role
end

When /^I assign (.*) as (a|an) (.*) to the proposal permissions$/ do |username, x, role|
  set(username, (make UserObject, user: username))
  @proposal.permissions.send(snake_case(role+'s')) << username
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
      on Proposal do |page|
        page.save_button.should be_present
        page.abstracts_and_attachments
      end
      on AbstractsAndAttachments do |page|
        page.save_button.should be_present
        page.custom_data
      end
      on CustomData do |page|
        page.save_button.should be_present
        page.key_personnel
      end
      on KeyPersonnel do |page|
        page.save_button.should be_present
        page.permissions
      end
      on Permissions do |page|
        page.save_button.should be_present
        page.proposal_actions
      end
      on ProposalActions do |page|
        page.save_button.should be_present
        page.questions
      end
      on Questions do |page|
        page.save_button.should be_present
        page.special_review
      end
      on SpecialReview do |page|
        page.save_button.should be_present
      end

    when 'only update the budget'
      on(Proposal).budget_versions
      @proposal.close
      on(QuestionDialogPage).yes

    when 'only read the proposal'
      on Proposal do |page|
        page.save_button.should_not be_present
        page.abstracts_and_attachments
      end
      on AbstractsAndAttachments do |page|
        page.save_button.should_not be_present
        page.custom_data
      end
      on CustomData do |page|
        page.save_button.should_not be_present
        page.key_personnel
      end
      on KeyPersonnel do |page|
        page.save_button.should_not be_present
        page.permissions
      end
      on Permissions do |page|
        page.save_button.should_not be_present
        page.proposal_actions
      end
      on ProposalActions do |page|
        page.save_button.should_not be_present
        page.questions
      end
      on Questions do |page|
        page.save_button.should_not be_present
        page.special_review
      end
      on SpecialReview do |page|
        page.save_button.should_not be_present
      end

    when 'delete the proposal'
      on(Proposal).proposal_actions
      @proposal.delete
  end
end

Then /^I should see an error message that says not to select other roles alongside aggregator$/ do
   on(Roles).errors.should include 'Do not select other roles when Aggregator is selected.'
end

When /^I attempt to add an additional role to (.*)$/ do |username|
  role = [:viewer, :budget_creator, :narrative_writer].sample
  on(Permissions).edit_role(get(username).user_name)
  on Roles do |page|
    page.use_new_tab
    page.send(role).set
    page.save
  end
end