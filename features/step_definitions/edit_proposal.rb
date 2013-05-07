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
  @proposal.view(:proposal_actions)
  on ProposalActions do |page|
    page.expand_all
    puts page.actions_taken_table.text
    puts page.actions.inspect
    page.actions.should include value
  end
end
