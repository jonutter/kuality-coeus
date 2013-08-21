When /^I? ?add an employee to the budget's project personnel$/ do
  @budget_version.add_project_personnel
end

When /^I? ?add a non-employee to the budget's project personnel$/ do
  @budget_version.add_project_personnel type: 'non_employee'
end

When /^I? ?add a to-be-named person to the budget's project personnel$/ do
  @budget_version.add_project_personnel type: 'to_be_named'
end