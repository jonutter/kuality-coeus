When /^I create a budget version for the proposal$/ do
  @proposal.add_budget_version
end

Then /^opening the Budget Version will display a warning about the date change$/ do
  @proposal.budget_versions[0].open
  on(Parameters).warnings.should include 'The Project Start and/or End Dates have changed from the previous version of this budget. Please update the Project Start and/or End Dates.'
end


