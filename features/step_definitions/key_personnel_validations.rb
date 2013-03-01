Then /^I should see an error that the credit split is not a valid percentage$/ do
  on(KeyPersonnel).combined_credit_split_errors.should include 'Credit Split is not a valid percentage.'
end

Then /^I should see an error that only one PI is allowed$/ do
  on(KeyPersonnel).add_validation_errors.should include 'Only one proposal role of Principal Investigator is allowed.'
end