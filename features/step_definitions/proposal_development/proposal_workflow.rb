# This step mentions user roles because it best fits into the context of
# our 'Given we have users with the roles' step
When /^I? ?send a notification to the (.*) users?$/ do |role|
  role = role.split(', ')

  on(PDCustomData).proposal_actions
  role.each do |role|
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

When /^I? ?recall the proposal for revisions$/ do
  @proposal.recall :revisions
end

When /^I? ?recall and cancel the proposal$/ do
  @proposal.recall :cancel
end

Then /^the proposal status should be (.*)$/ do |status|
  @proposal.status.should == status
end

Then(/^I should receive an action list item with the requested action being: (.*)$/) do |action|
  visit ActionList do |page|
    page.last
    # This code is needed because the list refresh
    # may not happen immediately...
    x = 0
    while x < 4
      break if page.item_row(@proposal.document_id.to_i + 1).exists?
      sleep 1
    # The page refresh is necessary because the proposal
    # may reach the user's action list with delay
      page.refresh
    # After a refresh, you'll need to visit the last page
    # again to view most recent proposals
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

When /^I? ?submit the routed proposal to the sponsor$/ do



sleep 30



  @proposal.submit :to_sponsor
end

When /^I? ?submit the proposal to S2S$/ do
  @proposal.submit :to_s2s
end

When(/^I? ?blanket approve the proposal$/) do
  @proposal.blanket_approve
end