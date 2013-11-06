When /^I? ?initiate an Award for the institutional_proposal$/ do
  @award = create AwardObject, funding_proposal: @institutional_proposal.proposal_number
end

When /^I? ?initiate an Award$/ do
  # Implicit in this step is that the Award creator
  # is creating the Award in the unit they have
  # rights to. This is why this step specifies what the
  # Award's unit should be...
  lead_unit = $users.current_user.roles.name($users.current_user.role).qualifiers[0][:unit]
  # A catch-all in case lead_unit is still nil. Not quite sure what
  # to do in that case, though, so it will pick randomly, for now...
  lead_unit ||= '::random::'
  @award = create AwardObject, lead_unit: lead_unit
end

Given /^I? ?initiate an Award with (.*) as the Lead Unit$/ do |lead_unit|
  @award = create AwardObject, lead_unit: lead_unit
end

When /^I ? ?initiate an Award with a missing required field$/ do
  @required_field = ['Description', 'Transaction Type', 'Award Status', 'Award Title',
                     'Activity Type', 'Award Type', 'Project Start Date', 'Project End Date',
                     'Lead Unit', 'Obligation Start Date', 'Obligation End Date',
                     'Anticipated Amount', 'Obligated Amount', 'Transactions'
  ].sample
  @required_field=~/Type/ ? value='select' : value=''
  field = snake_case(@required_field)
  @proposal = create AwardObject, field=>value
end