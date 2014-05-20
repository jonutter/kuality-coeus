Given /^I? ?add a T&M transaction from External to the Award, with obligated and anticipated amounts of (.*)$/ do |change|
  @award.time_and_money.add_transaction source_award: 'External',
                                        destination_award: @award.id,
                                        obligated_change: change,
                                        anticipated_change: change
end

And /^the Time & Money Modifier submits the Award's T&M document$/ do
  steps '* log in with the Time And Money Modifier user'
  # This line is included because it can simplify scenarios.
  # It's safe because if the T&M document already exists
  # then all this method does is open it...
  @award.initialize_time_and_money
  @award.time_and_money.submit
end

And /cancels the Time And Money document$/ do
  @award.time_and_money.cancel
end

And /the Time And Money Modifier opens the Award's Time And Money document/ do
  steps '* log in with the Time And Money Modifier user'
  @award.view :award
  on(Award).time_and_money
end

Then /the T&M document is still the finalized version/ do
  @award.time_and_money.check_status
  @award.time_and_money.status.should=='FINAL'
  @award.time_and_money.versions.should be_empty
end

Then /^the Time And Money document should not be the cancelled version$/ do
  @award.time_and_money.check_status
  @award.time_and_money.status.should == 'SAVED'
  @award.time_and_money.versions.should_not be_empty
end