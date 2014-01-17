#----------------------#
#Create and Save
#Note: Units are specified to match the initiator's unit.
#----------------------#
When /^I? ?creates? an Award as the (.*) user$/ do |role_name|
  steps %{ Given I log in with the #{role_name} user }
  # Implicit in this step is that the Award creator
  # is creating the Award in the unit they have
  # rights to. This is why this step specifies what the
  # Award's unit should be...
  lead_unit = $users.current_user.roles.name($users.current_user.role).qualifiers[0][:unit]
  raise 'Unable to determine a lead unit for the selected user. Please debug your scenario.' if lead_unit.nil?
  @award = create AwardObject, lead_unit: lead_unit
end

Given /^I? ?creates? an Award with (.*) as the Lead Unit$/ do |lead_unit|
  @award = create AwardObject, lead_unit: lead_unit
end

#----------------------#
#Award Validations Based on Errors During Creation
#----------------------#
When /^I ? ?creates? an Award with a missing required field$/ do
  @required_field = ['Description', 'Transaction Type', 'Award Status',
                     'Award Title', 'Activity Type', 'Award Type',
                     'Project End Date', 'Lead Unit', 'Obligation Start Date',
                     'Obligation End Date','Anticipated Amount'
  ].sample
  @required_field=~/(Type|Status)/ ? value='select' : value=' '
  field = snake_case(@required_field)
  @award = create AwardObject, field=>value
end

Given /^the Award Modifier creates an Award$/ do
  steps %q{
  * I log in with the Award Modifier user
  * I create an Award
}
end

Given /^the Award Modifier creates an Award including an Account ID, Account Type, Prime Sponsor, and CFDA Number$/ do
  steps 'Given I log in with the Award Modifier user'
  @award = create AwardObject
end

Then /^a new Institutional Proposal should be generated$/ do
  #TODO: Finish this step
  raise "This is not a finished step!!!"
end