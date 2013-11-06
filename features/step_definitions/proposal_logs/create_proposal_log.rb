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

Then(/^the proposal log type of the proposal log document should be (.*)$/) do |status|
  @proposal_log2.proposal_log_type.should == status
end

Then(/^the status of the proposal log document should be (.*)$/) do |status|
  @proposal_log.status.should == status
end

When(/^the proposal log status should be (.*)$/) do |prop_log_status|
  @proposal_log.log_status.should == prop_log_status
end
When(/^I submit a new permanent proposal log document with the same PI into routing$/) do
  @proposal_log2 = create ProposalLogObject,
                          principal_investigator: @temp_proposal_log.principal_investigator
  @proposal_log2.submit
end

When(/^I initiate a new permanent proposal log document$/) do
  @proposal_log = create ProposalLogObject
end

When(/^I? ?submit a new temporary proposal log document with the pi (.*)$/) do |pi_user_name|
  @temp_proposal_log = create ProposalLogObject,
                         log_type: 'Temporary',
                         principal_investigator: pi_user_name
  @temp_proposal_log.submit
end

Then(/^I merge my new proposal log with my previous temporary proposal log$/) do
  on ProposalLog do |page|
    page.temporary_proposal_log_table
    page.merge(@temp_proposal_log.number.to_i + 1)
  end
end

When(/^I submit a new proposal log$/) do
  @proposal_log = create ProposalLogObject
  @proposal_log.submit
end

When(/^I submit a new temporary proposal log document$/) do
  @temp_proposal_log = create ProposalLogObject,
                              log_type: 'Temporary'
  @temp_proposal_log.submit
end