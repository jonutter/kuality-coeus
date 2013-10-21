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
When(/^I initiate a new permanent proposal log document with the same PI$/) do
  @proposal_log2 = create ProposalLogObject,
                          principal_investigator: @temp_proposal_log.principal_investigator
end
When(/^I initiate a new permanent proposal log document$/) do
  @proposal_log = create ProposalLogObject
end
When(/^I? ?initiate a new temporary proposal log document$/) do
  @temp_proposal_log = create ProposalLogObject,
                         log_type: 'Temporary'
end
Then(/^I should be able to merge my new proposal log with my previous temporary proposal log$/) do
  on ProposalLog do |page|
    page.temporary_proposal_log_table
    page.merge(@temp_proposal_log.proposal_number.to_i + 1)
  end
end