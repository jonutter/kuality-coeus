When(/^I initiate a proposal with the NIH sponsor$/) do
  @proposal = create ProposalDevelopmentObject, sponsor_code: '000340'
end
Given(/^I initiate an IRB protocol$/) do
  pending
end