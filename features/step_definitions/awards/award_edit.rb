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

And /edits the finalized Award$/ do
  @award.edit transaction_type: '::random::', anticipated_amount: '5', obligated_amount: '5'
end

When /^the original Award is edited again$/ do
  visit DocumentSearch do |search|
    search.document_id.set @award.prior_versions['1']
    search.search
    search.open_doc @award.prior_versions['1']
  end
  on(Award).edit
end

And /^selecting 'yes' takes you to the pending version$/ do
  on(Confirmation).yes
  on Award do |page|
    page.header_document_id.should==@award.document_id
  end
end

Then /^selecting 'no' on the confirmation screen creates a new version of the Award$/ do
  on(Confirmation).no
  on Award do |page|
    page.header_document_id.should_not == @award.document_id
    page.header_document_id.should_not == @award.prior_versions[1]
  end
end

When(/^the Award Modifier cancels the Award$/) do
  steps '* log in with the Award Modifier user'
  @award.cancel
end