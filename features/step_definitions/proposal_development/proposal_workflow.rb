# This step mentions user roles because it best fits into the context of
# our 'Given we have users with the roles' step
When /^they send a notification to the (.*) users?$/ do |role|
  role = role.split(', ')

  on(PDCustomData).proposal_actions
  on(ProposalActions).send_notification
  role.each do |role|
    user_name = get(role).user_name
    on(NotificationEditor).employee_search
    on PersonLookup do |page|
      page.user_name.set user_name
      page.search
      page.return_value user_name
    end
    on(NotificationEditor).add
  end
  on NotificationEditor do |page|
    page.subject.set random_alphanums
    page.message.set random_multiline
    page.send_fyi
  end
end

Then /^the Proposal status should be (.*)$/ do |status|
  @proposal.status.should == status
end

# Only parameterize the user when necessary!
Then /^the OSPApprover's requested Proposal action should be: (.*)$/ do |action|
  steps '* log in with the OSPApprover user'


  # DEBUG
  puts @proposal.document_id
  visit(ActionList).filter
  on ActionListFilter do |page|
    page.document_title.set @proposal.project_title
    page.filter
  end

  sleep 180
  exit

  visit ActionList do |page|




    page.last if page.last_button.present?
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

Then /^they can acknowledge the requested action list item$/ do
  on ActionList do |page|
    page.action(@proposal.document_id.to_i + 1).select 'FYI'
    page.take_actions
  end
end

When /^I? ?submit the Proposal to its sponsor$/ do
  @proposal.submit :to_sponsor
  @institutional_proposal = @proposal.make_institutional_proposal
end

And /^the (.*) submits the Proposal to its sponsor$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @proposal.view :proposal_actions
  @proposal.submit :to_sponsor
  @institutional_proposal = @proposal.make_institutional_proposal
end

When /^I? ?submit the Proposal to S2S$/ do
  @proposal.submit :to_s2s
end

When /^(I? ?submits? the Proposal|the Proposal is submitted)$/ do |x|
  @proposal.submit
end

When /^I? ?blanket approve the Proposal$/ do
  @proposal.blanket_approve
end

And /^the principal investigator approves the Proposal$/ do
  $users.logged_in_user.sign_out unless $users.current_user==nil
  visit Login do |log_in|
    log_in.username.set @proposal.key_personnel.principal_investigator.user_name
    log_in.login
  end
  @proposal.approve_from_action_list
  visit(Researcher).logout
end

And /^the (.*) approves the Proposal (with|without) future approval requests$/ do |role_name, future_requests|
  steps %{* I log in with the #{role_name} user }
  conf = {'with' => :yes, 'without' => :no}
  @proposal.approve_from_action_list
  on(Confirmation).send(conf[future_requests])
end

Then /^I should only have the option to submit the proposal to its sponsor$/ do
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.approve_button.should_not be_present
    page.submit_to_sponsor_button.should be_present
  end
end

Then /^I should see the option to approve the Proposal$/ do
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.approve_button.should be_present
  end
end

Then /^I should not see the option to approve the Proposal$/ do
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.approve_button.should_not be_present
  end
end

And(/^the (.*) approves the Proposal again$/) do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @proposal.approve
end