When /^I? ?create an award for the institutional_proposal$/ do
  @award = create AwardObject, funding_proposal: @institutional_proposal.proposal_number
end

When /^I? ?initiate an award document$/ do
  @award = create AwardObject
end

Given /^I? ?initiate an Award with (.*) as the Lead Unit$/ do |lead_unit|
  @award = create AwardObject, lead_unit: lead_unit
end

When /^I ? ?initiate an award document with a missing required field$/ do
  @required_field = ['Description', 'Transaction Type', 'Award Status', 'Award Title',
                     'Activity Type', 'Award Type', 'Project Start Date', 'Project End Date',
                     'Lead Unit', 'Obligation Start Date', 'Obligation End Date',
                     'Anticipated Amount', 'Obligated Amount', 'Transactions'
  ].sample
  @required_field=~/Type/ ? value='select' : value=''
  field = snake_case(@required_field)
  @proposal = create AwardObject, field=>value
end