When(/^I submit a new Award Sponsor Template without Sponsor Template Terms$/) do
  steps %{ * I log in with the Modify Sponsor Template user }
  @sponsor_template = create SponsorTemplateObject
end