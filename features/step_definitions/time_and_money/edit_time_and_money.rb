Given /^I? ?add a T&M transaction from External to the Award, with obligated and anticipated amounts of (.*)$/ do |change|
  @award.time_and_money.add_transaction source_award: 'External',
                                        destination_award: @award.id,
                                        obligated_change: change,
                                        anticipated_change: change
end