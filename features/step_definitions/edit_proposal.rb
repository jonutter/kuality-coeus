When /^I recall the proposal$/ do
  @proposal.recall
end

When /^I complete a valid simple proposal for a (.*) organization$/ do ||
  @proposal = create ProposalDevelopmentObject, sponsor_type_code: org
  @proposal.add_principal_investigator
  @proposal.set_valid_credit_splits
  @proposal.add_custom_data
end