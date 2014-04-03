# coding: UTF-8
Given /I? ?add a Sponsor Contact to the Award$/ do
  @award.add_sponsor_contact
end

When /^an Account ID with special characters is added to the Award details$/ do
  @award.edit account_id: random_string(6, %w{~ ! @ # $ % ^ &}.sample)
end

When /^the Award's title is updated to include invalid characters$/ do
  @award.edit award_title: random_high_ascii(100)
end

When /^the Award's title is made more than (\d+) characters long$/ do |arg|
  @award.edit award_title: random_high_ascii(arg.to_i+1)
end

When /I? ?adds? the required Custom Data to the Award$/ do
  @award.add_custom_data if @award.custom_data.nil?
end

When /completes? the Award requirements$/ do
  steps %q{
    * add a Report to the Award
    * add Terms to the Award
    * add the required Custom Data to the Award
    * add a Payment & Invoice item to the Award
    * add a Sponsor Contact to the Award
    * add a PI to the Award
    * give the Award valid credit splits
  }
end

When /^data validation is turned on for the Award$/ do
  @award.view :award_actions
  on AwardActions do |page|
    page.expand_all
    page.turn_on_validation
  end
end

#----------------------#
#Subawards
#----------------------#
Given /^I? ?adds? a subaward to the Award$/ do
  @award.add_subaward
end

Given /I? ?adds? a \$(.*) Subaward to the Award$/ do |amount|
  @award.add_subaward 'random', amount
end

And /adds the same organization as a subaward again to the Award$/ do
  @award.add_subaward @award.subawards[0][:org_name]
end