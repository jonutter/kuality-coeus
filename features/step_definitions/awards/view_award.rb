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