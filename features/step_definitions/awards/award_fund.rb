When /^I? ?initiate an Award for the Institutional Proposal$/ do
  @award = create AwardObject, funding_proposals: @institutional_proposal.proposal_number
end

When /^the (.*) tries to fund an Award with the new Institutional Proposal$/ do |role_name|
  steps %{ Given I log in with the #{role_name} user }
  @award = create AwardObject
  @award.add_funding_proposal @institutional_proposal.proposal_number, '::random::'
end