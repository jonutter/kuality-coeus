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
When(/^I create a proposal log document$/) do
  @proposal_log = create ProposalLogObject
end