
Then /^the Proposal status should be (.*)$/ do |status|
  @proposal.status.should == status
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