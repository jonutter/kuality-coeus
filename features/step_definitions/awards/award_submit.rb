When /^the (.*) user submits the Award$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @award.submit
end

When /^the (.*) user submits the copied Award$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @award_2.submit
end