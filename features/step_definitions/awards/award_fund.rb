When /I? ?add the (.*) Institutional Proposal to the Award$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'No Change'
end

When /I? ?merge the (.*) Institutional Proposal with the Award$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'Merge'
end

When /I? ?replace the current Institutional Proposal in the Award with (.*)$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'Replace'
end

When /^I? ?initiate an Award for the institutional_proposal$/ do
  @award = create AwardObject, funding_proposal: @institutional_proposal.proposal_number
end