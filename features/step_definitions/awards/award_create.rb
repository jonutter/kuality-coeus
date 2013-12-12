#----------------------#
#Create and Save
#Note: Units are specified to match the initiator's unit.
#----------------------#
When /^I? ?initiate an Award$/ do
  # Implicit in this step is that the Award creator
  # is creating the Award in the unit they have
  # rights to. This is why this step specifies what the
  # Award's unit should be...
  lead_unit = $users.current_user.roles.name($users.current_user.role).qualifiers[0][:unit]
  raise 'Unable to determine a lead unit for the selected user. Please debug your scenario.' if lead_unit.nil?
  @award = create AwardObject, lead_unit: lead_unit
end

Given /^the Award Modifier starts an Award with the first institutional proposal number$/ do
  steps 'Given I log in with the Award Modifier user'
  visit(CentralAdmin).create_award
  on Award do |page|
    page.expand_all
    page.institutional_proposal_number.set @ips[0].proposal_number
    page.add_proposal
  end
end

Given /^I? ?initiate an Award with (.*) as the Lead Unit$/ do |lead_unit|
  @award = create AwardObject, lead_unit: lead_unit
end

#----------------------#
#Award Validations Based on Errors During Creation
#----------------------#
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

Given /^the Award Modifier creates an Award$/ do
  steps %q{
Given I log in with the Award Modifier user
And I initiate an Award
}
end

