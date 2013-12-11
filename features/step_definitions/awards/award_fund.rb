When /I? ?add the (.*) Institutional Proposal to the Award$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'No Change'
end

When /I? ?merge the (.*) Institutional Proposal with the Award$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'Merge'
end

When /I? ?replace the current Institutional Proposal in the Award with (.*)$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'Replace'
end

When /^I? ?initiate an Award for the Institutional Proposal$/ do
  @award = create AwardObject, funding_proposals: @institutional_proposal.proposal_number
end

When /^the (.*) tries to fund an Award with the new Institutional Proposal$/ do |role_name|
  steps %{ Given I log in with the #{role_name} user }
  @award = create AwardObject, funding_proposals: [{ip_number: @institutional_proposal.proposal_number}]
  on(Award).add_proposal
end