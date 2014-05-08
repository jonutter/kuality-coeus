When /^I? ?recall the Proposal$/ do
  @proposal.recall
end

When /^I? ?reject the Proposal$/ do
  @proposal.reject
end

When /^I? ?complete a valid simple Proposal for a '(.*)' organization$/ do |org|
  @proposal = create ProposalDevelopmentObject, sponsor_type_code: org
  @proposal.add_principal_investigator
  @proposal.set_valid_credit_splits
  @proposal.add_custom_data
end

Then /^The Proposal should immediately have a status of '(.*)'$/ do |status|
  @proposal.status.should==status
end

Then /^The proposal route log's 'Actions Taken' should include '(.*)'$/ do |value|
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.expand_all
    page.actions_taken.should include value
  end
end

Then /^The proposal route log's 'Pending Action Requests' should include '(.*)'$/ do |action|
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.expand_all
    page.action_requests.should include action
  end
end

Then /^The S2S tab should become available$/ do
  @proposal.view 'S2S'
  on(S2S).s2s_header.should be_present
end

When /^The Proposal's 'Future Action Requests' should include 'PENDING APPROVE' for the principal investigator$/ do
  pi = @proposal.key_personnel.principal_investigator
  name = "#{pi.last_name}, #{pi.first_name}"
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.expand_all
    page.show_future_action_requests
    page.requested_action_for(name).should=="PENDING\nAPPROVE"
  end
end

When /^I? ?push the Proposal's project start date ahead (\d+) years?$/ do |year|
  new_year=@proposal.project_start_date[/\d+$/].to_i+year.to_i
  new_date="#{@proposal.project_start_date[/^\d+\/\d+/]}/#{new_year}"
  @proposal.edit project_start_date: new_date
end

When /^the Proposal Creator pushes the end date (\d+) more years?$/ do |year|
  new_year=@proposal.project_end_date[/\d+$/].to_i+year.to_i
  new_date="#{@proposal.project_end_date[/^\d+\/\d+/]}/#{new_year}"
  @proposal.edit project_end_date: new_date
end

Then /^I can recall the Proposal$/ do
  @proposal.view 'Proposal'
  on(Proposal).recall_button.should exist
end

And /^I? ?answer the S2S questions$/ do
  @proposal.complete_s2s_questionnaire
end

Given /^I? ?set the proposal type to '(\w+)'$/ do |type|
  @proposal.edit proposal_type: type
end

When /^I go to the Proposal's (.*) page$/ do |page|
  @proposal.view page
end

When /^I? ?save the Proposal$/ do
  @proposal.save
end

Given /^I? ?set the proposal type to either 'Resubmission', 'Renewal', or 'Continuation'$/ do
  type = %w{Resubmission Renewal Continuation}.sample
  @proposal.edit proposal_type: type
end

When(/^the AOR user submits the Proposal to S2S$/) do
  @aor.sign_in
  steps '* I submit the Proposal to S2S'
end

And /^the Proposal Creator copies the Proposal, generating a new version of the Institutional Proposal$/ do
  steps '* I log in with the Proposal Creator user'
  @new_proposal_version = @proposal.copy_to_new_document
  @new_proposal_version.edit proposal_type: 'Continuation', original_ip_id: @institutional_proposal.proposal_number
  @new_proposal_version.key_personnel.principal_investigator.certification
  @new_proposal_version.submit
  steps '* I log in with the OSPApprover user'
  @new_proposal_version.approve_from_action_list
  on(Confirmation).send(:no)
  $users.logged_in_user.sign_out
  visit Login do |log_in|
    log_in.username.set @new_proposal_version.key_personnel.principal_investigator.user_name
    log_in.login
  end
  @new_proposal_version.approve_from_action_list
  visit(Researcher).logout
  steps '* I log in with the OSP Administrator user'
  @new_proposal_version.view :proposal_actions
  @new_proposal_version.resubmit
end

Then /^it is still possible to copy the Proposal$/ do
  expect{@proposal.copy_to_new_document}.not_to raise_error
end