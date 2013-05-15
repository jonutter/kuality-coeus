When /^I create a budget version for the proposal$/ do
  @proposal.add_budget_version
  @budget_version = @proposal.budget_versions[0]
end

Then /^opening the Budget Version will display a warning about the date change$/ do
  @budget_version.open
  on(Parameters).warnings.should include 'The Project Start and/or End Dates have changed from the previous version of this budget. Please update the Project Start and/or End Dates.'
end

When /^correcting the Budget Version date will remove the warning$/ do
  # TODO: Consider writing code that could shorten this to: @budget_version.default_periods
  on Parameters do |page|
    page.default_periods
    page.save
    page.warnings.size.should be 0
  end
end

When /^I copy the budget version \(all periods\)$/ do
  name_of_budget_copy=random_alphanums
  @proposal.budget_versions.copy_all_periods(@budget_version.name, name_of_budget_copy)
  @copied_budget_version=@proposal.budget_versions.budget(name_of_budget_copy)
  #puts @proposal.budget_versions.inspect
end

When /^I enter values for all the budget periods$/ do
  @budget_version.budget_periods.each do |period|
    period.edit direct_cost: random_dollar_value(500000),
                f_and_a_cost: random_dollar_value(500000),
                unrecovered_f_and_a: random_dollar_value(500000),
                cost_sharing: random_dollar_value(500000),
                cost_limit: random_dollar_value(500000),
                direct_cost_limit: random_dollar_value(500000)
  end
end
Then /^the copied budget's values are all as expected$/ do
  @copied_budget_version.open
  @copied_budget_version.budget_periods.each do |period|
     on Parameters do |page|
       page.start_date_period(period.number).value.should==period.start_date
       page.end_date_period(period.number).value.should==period.end_date
       page.total_sponsor_cost_period(period.number).value.should==(period.direct_cost+period.f_and_a_cost).commas
       page.direct_cost_period(period.number).value.should==period.direct_cost.commas
       page.fa_cost_period(period.number).value.should==period.f_and_a_cost.commas
       page.unrecovered_fa_period(period.number).value.should==period.unrecovered_f_and_a.commas
       page.cost_sharing_period(period.number).value.should==period.cost_sharing.commas
       page.cost_limit_period(period.number).value.should==period.cost_limit.commas
       page.direct_cost_limit_period(period.number).value.should==period.direct_cost_limit.commas
     end
  end
end