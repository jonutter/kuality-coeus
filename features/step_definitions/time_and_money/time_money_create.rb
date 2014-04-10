Given /^the Time And Money Modifier initializes the Award's Time And Money document$/ do
  steps '* I log in with the Time And Money Modifier user'
  @award.initialize_time_and_money
end

Then /^a new T&M Document is created$/ do
  @award.time_and_money.versions.should_not be_empty
  @award.time_and_money.versions[-1].should_not == on(TimeAndMoney).header_document_id
end