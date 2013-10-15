Then /^The Award PI's Lead Unit is (.*)$/ do |unit|
  @award.key_personnel.principal_investigator.lead_unit.should==unit
end

Then /^the Award's Lead Unit is changed to (.*)$/ do |unit|
  @award.view 'Award'
  on(Award).lead_unit_ro.should=~/^#{unit}/
end