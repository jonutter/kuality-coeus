When /^(the (.*) |)submits the Award$/ do |text, role_name|
  steps %{ * I log in with the #{role_name} user } unless text == ''
  @award.submit
end

When /^the (.*) user submits the copied Award$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @award_2.submit
end