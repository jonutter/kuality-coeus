Given /^I? ?add a T&M transaction from External to the Award, with obligated and anticipated amounts of (.*)$/ do |change|
  @award.time_and_money.add_transaction source_award: 'External',
                                        destination_award: @award.id,
                                        obligated_change: change,
                                        anticipated_change: change
end

And /^I? ?submit the Award's T&M document$/ do
  # This line is included because it can simplify scenarios.
  # It's safe because if the T&M document already exists
  # then all this method does is open it...
  @award.initialize_time_and_money
  @award.time_and_money.submit
end