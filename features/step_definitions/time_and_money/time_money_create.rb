Given /^the Time And Money Modifier initializes the Award's Time And Money document$/ do
  steps '* I log in with the Time And Money Modifier User'
  @award.initialize_time_and_money
end