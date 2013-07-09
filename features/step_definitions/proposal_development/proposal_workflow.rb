# TODO: It's not clear from the text of this step definition that you're sending to *roles*. Consider rewriting
# because otherwise it reads as if you're sending to *usernames*
When /^I send a notification to the following users: (.*)$/ do |roles|
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
  @proposal.recall_for_revisions
end

When /^when the proposal is opened the status should be (.*)$/ do |status|
  on(ActionList).open_item(@proposal.document_id)
  @proposal.status = status
end

When /^I recall and cancel the proposal$/ do
  @proposal.recall_for_cancellation
end

Then /^the proposal status should be (.*)$/ do |status|
  @proposal.status.should==status
end

When /^I submit the proposal document$/ do
  @proposal.submit
end

Then(/^the proposal is in my action list as an (.*)$/) do |action|
  visit ActionList do |page|
    page.last
    x = 0
    until x == 3 && page.item_row(@proposal.document_id.to_i + 1).exists?
      sleep 1
      page.refresh
      page.last
      x += 1
    end
    page.action_requested(@proposal.document_id.to_i + 1).should == action
  end
end

Then /^I can acknowledge the requested action list item$/ do
  on ActionList do |page|
    page.action(@proposal.document_id.to_i + 1).select 'FYI'
    page.take_actions
  end
end

When /^I submit the routed proposal to a sponsor$/ do
  @proposal.submit_to_sponsor
end

When /^I submit the proposal to S2S$/ do
  @proposal.submit_to_s2s
end