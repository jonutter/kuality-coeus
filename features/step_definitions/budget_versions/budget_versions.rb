When /^(the (.*) user |)creates a Budget Version for the Proposal$/ do |text, role_name|
  steps %{ * I log in with the #{role_name} user } unless text==''
  @proposal.add_budget_version
  @budget_version = @proposal.budget_versions[0]
end

When /^I add a subaward budget to the Budget Version$/ do
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

Given /^(the (.*) user |)creates a final and complete Budget Version for the Proposal$/ do |text, role_name|
  steps %{ * I log in with the #{role_name} user } unless text ==''
  @proposal.add_budget_version status: 'Complete', final: :set
end

When /^I? ?copy the Budget Version \(all periods\)$/ do
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
    n = period.number
    on Parameters do |page|
      page.start_date_period(n).value.should==period.start_date
      page.end_date_period(n).value.should==period.end_date
      page.total_sponsor_cost_period(n).value.should==(period.direct_cost.to_f+period.f_and_a_cost.to_f).commas
      page.direct_cost_period(n).value.should==period.direct_cost.to_f.commas
      page.fa_cost_period(n).value.should==period.f_and_a_cost.to_f.commas
      page.unrecovered_fa_period(n).value.should==period.unrecovered_f_and_a.to_f.commas
      page.cost_sharing_period(n).value.should==period.cost_sharing.to_f.commas
      page.cost_limit_period(n).value.should==period.cost_limit.to_f.commas
      page.direct_cost_limit_period(n).value.should==period.direct_cost_limit.to_f.commas
    end
  end
end

When /deletes? one of the budget periods$/ do
  @budget_version.delete_period(rand(@budget_version.budget_periods.size)+1)
end

When /^I? ?changes? the date range for one of the periods$/ do
  period = @budget_version.budget_periods.sample
  new_start_date = '03'+period.start_date[/\/\d+\/\d+$/]
  new_end_date = '10'+period.end_date[/\/\d+\/\d+$/]
  period.edit start_date: new_start_date, end_date: new_end_date
  on(Confirmation).yes
end

When /selects? the default periods for the Budget Version$/ do
  @original_period_count = @budget_version.budget_periods.count
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

When /finalizes? the Budget Version$/ do
  @budget_version.edit final: :set
end

When /marks? the Budget Version complete$/ do
  @budget_version.edit status: 'Complete'
end

When /^(the (.*) user |)creates a Budget Version with cost sharing for the Proposal$/ do |text, role_name|
  steps %{ * I log in with the #{role_name} user } unless text==''
  @proposal.add_budget_version
  @budget_version = @proposal.budget_versions[0]
  @budget_version.edit_period(1, cost_sharing: random_dollar_value(1000000))
  @budget_version.budget_periods.period(1).cost_sharing_distribution_list.each do |cs|
    cs.edit source_account: random_alphanums
  end
end

And /^(the (.*) user |)creates a Budget Version with unrecovered F&A for the Proposal$/ do |text, role_name|
  steps %{ * I log in with the #{role_name} user } unless text==''
  @proposal.add_budget_version
  @budget_version = @proposal.budget_versions[0]
  steps %q{ * add unrecovered F&A to the first period of the Budget Version }
end

And /adds? unrecovered F&A to the first period of the Budget Version$/ do
  total_allocated = random_dollar_value(1000000).to_f
  first_amount = (total_allocated/4).round(2)
  amounts = [ first_amount.to_s, (total_allocated - first_amount).round(2).to_s ]
  @budget_version.edit_period(1, unrecovered_f_and_a: total_allocated)
  @budget_version.budget_periods.period(1).unrecovered_fa_dist_list.each_with_index do |ufna, index|
    ufna.edit source_account: random_alphanums, amount: amounts[index]
  end
end

And /^adds another item to the budget period's cost sharing distribution list$/ do
  @budget_version.budget_periods.period(1).add_item_to_cost_share_dl
end

And /^adjusts the budget period's cost sharing amount so all funds are allocated$/ do
  @budget_version.budget_periods.period(1).edit cost_sharing: @budget_version.budget_periods.period(1).cost_sharing_distribution_list.total_funds.to_s
end

Then /^the Budget Version is no longer editable$/ do
  @budget_version.view 'Budget Actions'
  on BudgetActions do |page|
    page.expand_all
    page.add_file_name.should_not be_present
  end
  # TODO: Add more validations here
end

Then /the Budget Version should have two more budget periods/ do
  @budget_version.budget_periods.count.should==@original_period_count+2
end