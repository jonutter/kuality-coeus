When(/^I initiate a proposal log document but I miss a required field$/) do
  # Pick a field at random for the test...
  @required_field = ['Title', 'Proposal Type', 'Lead Unit'
          ].sample
  # Properly set the nil value depending on the field type...
  @required_field=~/Type/ ? value='select' : value=''
  # Transform the field name to the appropriate symbol...
  field =snake_case(@required_field)
  @proposal_log = create ProposalLogObject, field=>value
end

When(/^I? ?initiate a new proposal log document$/) do
  @proposal_log = create ProposalLogObject
end

Then(/^the status of the proposal log document should be (.*)$/) do |status|
  @proposal_log.status.should == status
end

When(/^the proposal log status should be (.*)$/) do |prop_log_status|
  @proposal_log.log_status.should == prop_log_status
end
When(/^I initiate a second new proposal log document$/) do
  @proposal_log2 = create ProposalLogObject
end
When(/^I combine the two proposal log documents$/) do

end