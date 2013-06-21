When(/^I send a notification to the following users: (.*)$/) do |roles|
  roles = roles.split(', ')

  on(PDCustomData).proposal_actions
  roles.each do |role|
    user_name = get(role).user_name

    on ProposalActions do |page|
      page.send_notification
      page.employee_search
    end
    on PersonLookup do |page|
      page.user_name.set user_name
      page.search
      page.return_value user_name
    end
    on(ProposalActions).add
  end
  on(NotificationEditor).send_fyi
end

When /^I recall the proposal for revisions$/ do
  #TODO: Please fix the recall method
  @proposal.recall
  on Confirmation do |page|
    page.recall_reason.fit random_alphanums
    page.recall_to_action_list
  end
end

When /^when the proposal is opened the status should be (.*)$/ do |status|
  on(ActionList).open_item(@proposal.document_id)
  @proposal.status = status
end

When /^I recall and cancel the proposal$/ do
  #TODO: Please fix the recall method
  @proposal.recall
  on Confirmation do |page|
    page.recall_reason.fit random_alphanums
    page.recall_and_cancel
  end
end

Then /^the proposal status should be (.*)$/ do |status|
  @proposal.open_proposal
  @proposal.status = status
end

Then(/^I can submit the proposal document$/) do
  @proposal.submit
end

Then(/^the proposal is in the OSPApprover user's action list as an (.*)$/) do |action_requested|
  visit ActionList do |page|
    page.last
    x = 0
    while x < 10 && page.item_row(@proposal.document_id.to_i + 1).exists?
      sleep 1
      page.refresh
      page.last
      x += 1
    end
    page.action_requested(@proposal.document_id.to_i + 1).should == action_requested
  end
end

Then /^the OSPApprover user can Acknowledge the requested action list item$/ do
  on ActionList do |page|
    page.actions.(@proposal.document_id.to_i + 1).select 'FYI'
  end
end
