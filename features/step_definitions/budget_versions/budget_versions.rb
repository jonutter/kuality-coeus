When /^I? ?create a budget version for the proposal$/ do
  @proposal.add_budget_version
  @budget_version = @proposal.budget_versions[0]
end

When /^I? ?add a subaward budget to the budget version$/ do
  @budget_version.add_subaward_budget
end

Then /^opening the Budget Version will display a warning about the date change$/ do
  @budget_version.open_budget
  on(Parameters).warnings.should include 'The Project Start and/or End Dates have changed from the previous version of this budget. Please update the Project Start and/or End Dates.'
end

When /^correcting the Budget Version date will remove the warning$/ do
  @budget_version.default_periods
  on(Parameters).warnings.size.should be 0
end

Given /^I? ?create, finalize, and mark complete a budget version for the proposal$/ do
  @proposal.add_budget_version status: 'Complete', final: :set
end

When /^I? ?copy the budget version \(all periods\)$/ do
  @copied_budget_version = @budget_version.copy_all_periods random_alphanums
end

When /^I? ?enter dollar amounts for all the budget periods$/ do
  @budget_version.budget_periods.each do |p|
    randomized_values = {}
    p.dollar_fields[1..-1].each { |f| randomized_values.store(f, random_dollar_value(500000)) }
    p.edit randomized_values
  end
end

Then /^the copied budget's values are all as expected$/ do
  @copied_budget_version.open_budget
  @copied_budget_version.budget_periods.each do |period|
    on Parameters do |page|
      page.start_date_period(period.number).value.should==period.start_date
      page.end_date_period(period.number).value.should==period.end_date
      page.total_sponsor_cost_period(period.number).value.should==(period.direct_cost.to_f+period.f_and_a_cost.to_f).commas
      page.direct_cost_period(period.number).value.should==period.direct_cost.to_f.commas
      page.fa_cost_period(period.number).value.should==period.f_and_a_cost.to_f.commas
      page.unrecovered_fa_period(period.number).value.should==period.unrecovered_f_and_a.to_f.commas
      page.cost_sharing_period(period.number).value.should==period.cost_sharing.to_f.commas
      page.cost_limit_period(period.number).value.should==period.cost_limit.to_f.commas
      page.direct_cost_limit_period(period.number).value.should==period.direct_cost_limit.to_f.commas
    end
  end
end

When /^I? ?delete one of the budget periods$/ do
  @budget_version.delete_period(rand(@budget_version.budget_periods.size)+1)
end

When /^I? ?change the date range for one of the periods$/ do
  period = @budget_version.budget_periods.sample
  new_start_date = '03'+period.start_date[/\/\d+\/\d+$/]
  new_end_date = '10'+period.end_date[/\/\d+\/\d+$/]
  period.edit start_date: new_start_date, end_date: new_end_date
  on(Confirmation).yes
end

When /^I? ?select the default periods for the budget version$/ do
  @budget_version.default_periods
end

Then /^all budget periods get recreated, zeroed, and given default date ranges$/ do
  default_start_dates={1=>@proposal.project_start_date}
  default_end_dates={@years=>@proposal.project_end_date}
  1.upto(@years-1) do |i|
    default_start_dates.store(i+1, "01/01/#{@proposal.project_start_date[/\d+$/].to_i+i}")
    default_end_dates.store(@years-i, "12/31/#{@proposal.project_end_date[/\d+$/].to_i-i}")
  end
  on(Parameters).period_count.should==@years
  on Parameters do |page|
    1.upto(@years) do |x|
      page.start_date_period(x).value.should==default_start_dates[x]
      page.end_date_period(x).value.should==default_end_dates[x]
      page.total_sponsor_cost_period(x).value.should=='0.00'
      page.direct_cost_period(x).value.should=='0.00'
      page.fa_cost_period(x).value.should=='0.00'
      page.unrecovered_fa_period(x).value.should=='0.00'
      page.cost_sharing_period(x).value.should=='0.00'
      page.cost_limit_period(x).value.should=='0.00'
      page.direct_cost_limit_period(x).value.should=='0.00'
    end
  end
end

When /^I? ?finalize the budget version$/ do
  @budget_version.edit final: :set
end

When /^I? ?mark the budget version complete$/ do
  @budget_version.edit status: 'Complete'
end

Then /^I see an error that only one version can be final$/ do
  on(BudgetVersions).errors.should include 'Only one Budget Version can be marked "Final".'
end
