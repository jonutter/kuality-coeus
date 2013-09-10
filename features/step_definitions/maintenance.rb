Given /^the Budget Column's '(.*)' has a lookup for '(.*)' that returns '(.*)'$/ do |name, look, ret|
  create BudgetColumnObject, name: name, lookup_argument: look, lookup_return: ret
end

Given /^the Budget Editable Column's include '(.*)'$/ do |column|
  create BudgetColumnObject, name: column
end