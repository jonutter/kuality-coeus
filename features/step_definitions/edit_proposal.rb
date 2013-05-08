When /^I recall the proposal$/ do
  @proposal.recall
end

When /^I complete a valid simple proposal for a '(.*)' organization$/ do |org|
  @proposal = create ProposalDevelopmentObject, sponsor_type_code: org
  @proposal.add_principal_investigator
  @proposal.set_valid_credit_splits
  @proposal.add_custom_data
end

Then /^The proposal should immediately have a status of '(.*)'$/ do |status|
  @proposal.status.should==status
end

Then /^The proposal's 'Actions Taken' should include '(.*)'$/ do |value|
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.expand_all
    page.actions.should include value
  end
end

Then /^The proposal's 'Pending Action Requests' should include '(.*)'$/ do |action|
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.expand_all
  end
end

Then /^The S2S tab should become available$/ do
  @proposal.view :s2s
  on(S2S).s2s_header.should be_present
end

When /^The proposal's 'Future Action Requests' should include 'PENDING APPROVE' for the principal investigator$/ do
  pi = @proposal.key_personnel.principal_investigator
  name = "#{pi.last_name}, #{pi.first_name}"
  @proposal.view :proposal_actions
  on ProposalActions do |page|
    page.expand_all
    page.show_future_action_requests
    puts page.requested_action_for(name).inspect
  end
end