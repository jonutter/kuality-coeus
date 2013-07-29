When /^I? ?visit the proposal's (.*) page$/ do |page|
  # Ensure we're where we need to be in the system...
  @proposal.open_document
  # Be sure that the page name used in the scenario
  # will be converted to the snake case value of
  # the method that clicks on the proposal's page tab.
  on(Proposal).send(snake_case(page))
end

Then /^the (.*) user is listed as an? (.*) in the proposal permissions$/ do |username, role|
  on(Permissions).assigned_role(get(username).user_name).should include role
end

When /^I? ?assign the (.*) user as an? (.*) in the proposal permissions$/ do |system_role, role|
  set(system_role, (make UserObject, role: system_role))
  @proposal.permissions.send(snake_case(role+'s')) << get(system_role).user_name
  @proposal.permissions.assign
end

Then /^the (.*) user can access the proposal$/ do |role|
  get(role).sign_in
  @proposal.open_proposal
  on(Researcher).error_table.should_not be_present
end

Then /^the proposal is in the (.*) user's action list$/ do |username|
  get(username).sign_in
  visit(ActionList).filter
  on ActionListFilter do |page|
    page.document_title.set @proposal.project_title
    page.filter
  end
  on(ActionList).item_row(@proposal.document_id).should exist
end

And /^their proposal permissions allow them to only update the Abstracts and Attachments page$/ do
  on(Proposal).abstracts_and_attachments
  @proposal.close
  on(Confirmation).yes
end

And /^their proposal permissions allow them to edit all parts of the proposal$/ do
  on Proposal do |page|
    page.save_button.should be_present
    page.abstracts_and_attachments
  end
  on AbstractsAndAttachments do |page|
    page.save_button.should be_present
    page.custom_data
  end
  on PDCustomData do |page|
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
end

And /^their proposal permissions allow them to only update the budget$/ do
      on(Proposal).budget_versions
      @proposal.close
      on(Confirmation).yes
end

And /^their proposal permissions allow them to only read the proposal$/ do
      on Proposal do |page|
        page.save_button.should_not be_present
        page.abstracts_and_attachments
      end
      on AbstractsAndAttachments do |page|
        page.save_button.should_not be_present
        page.custom_data
      end
      on PDCustomData do |page|
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
end

And /^their proposal permissions allow them to delete the proposal$/ do
      on(Proposal).proposal_actions
      @proposal.delete
end

Then /^there should be an error message that says not to select other roles alongside aggregator$/ do
   on(Roles).errors.should include 'Do not select other roles when Aggregator is selected.'
end

When /^I? ?attempt to add an additional proposal role to the (.*) user$/ do |system_role|
  role = [:viewer, :budget_creator, :narrative_writer, :aggregator].sample
  on(Permissions).edit_role.(get(system_role).user_name)
  on Roles do |page|
    page.use_new_tab
    page.send(role).set
    page.save
  end
end

Then /^the (.*) user should not be listed as an? (.*) in the second proposal$/ do |system_role, role|
  user = get(system_role)
  @proposal2.view :permissions
  on Permissions do |page|
    page.assigned_to_role(role).should_not include "#{user.first_name} #{user.last_name}"
  end
end
