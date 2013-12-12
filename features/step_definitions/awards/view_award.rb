Then /^The Award PI's Lead Unit is (.*)$/ do |unit|
  @award.key_personnel.principal_investigator.lead_unit.should==unit
end

Then /^the Award's Lead Unit is changed to (.*)$/ do |unit|
  @award.view 'Award'
  on(Award).lead_unit_ro.should=~/^#{unit}/
end

Then /^a warning appears saying tracking details won't be added until there's a PI$/ do
  on(PaymentReportsTerms).errors.should include 'Report tracking details won\'t be added until a principal investigator is set.'
end

Then /^the new Award should not have any subawards or T&M document$/ do
  on Award do |test|
    # If there are no Subawards, the table should only have 3 rows...
    test.approved_subaward_table.rows.size.should==3
    test.time_and_money
    # If there is no T&M, then an error should be thrown...
    test.errors.should include 'Project Start Date is required when creating a Time And Money Document.'
  end
end

Then /^the new Award's transaction type is 'New'$/ do
  on(Award).transaction_type.selected?('New').should be_true
end

Then /^the child Award's project end date should be the same as the parent, and read-only$/ do
  on(Award).project_end_date_ro.should==@award.project_end_date
end

Then /^the anticipated and obligated amounts are read-only and (.*)$/ do |amount|
  on Award do |page|
    page.anticipated_amount_ro.should==amount
    page.obligated_amount_ro.should==amount
  end
end

Then /^the anticipated and obligated amounts are zero$/ do
  on Award do |page|
    page.anticipated_amount.value.should=='0.00'
    page.obligated_amount.value.should=='0.00'
  end
end