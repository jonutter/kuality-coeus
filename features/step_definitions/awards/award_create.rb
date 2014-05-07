#----------------------#
#Create and Save
#Note: Units are specified to match the initiator's unit.
#----------------------#
When /^the (.*) creates an Award$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  # Implicit in this step is that the Award creator
  # is creating the Award in the unit they have
  # rights to. This is why this step specifies what the
  # Award's unit should be...
  lead_unit = $users.current_user.roles.name($users.current_user.role).qualifiers[0][:unit]
  raise 'Unable to determine a lead unit for the selected user. Please debug your scenario.' if lead_unit.nil?
  @award = create AwardObject, lead_unit: lead_unit
end

Given /^the Award Modifier creates? an Award with (.*) as the Lead Unit$/ do |lead_unit|
  steps '* I log in with the Award Modifier user'
  @award = create AwardObject, lead_unit: lead_unit
end

#----------------------#
#Award Validations Based on Errors During Creation
#----------------------#
When /^I ? ?creates? an Award with a missing required field$/ do
  required_field = ['Description','Transaction Type', 'Award Status',
                    'Award Title', 'Activity Type', 'Award Type',
                    'Project End Date', 'Lead Unit'
  ].sample
  required_field=~/(Type|Status)/ ? value='select' : value=' '
  field = damballa(required_field)
  @award = create AwardObject, field=>value
  text = ' is a required field.'
  @required_field_error = case(required_field)
                            when 'Description'
                              "Document #{required_field} (#{required_field})#{text}"
                            when 'Transaction Type', 'Award Status', 'Award Title', 'Activity Type', 'Award Type', 'Project End Date', 'Lead Unit'
                              "#{required_field} (#{required_field})#{text}"
                            end
end

When /^the Award Modifier creates an Award with more obligated than anticipated amounts$/ do
  steps '* I log in with the Award Modifier user'
  @award = create AwardObject, anticipated_amount: '9999.99', obligated_amount: '10000.00'
end

Given /^the Award Modifier creates an Award including an Account ID, Account Type, Prime Sponsor, and CFDA Number$/ do
  steps '* I log in with the Award Modifier user'
  @award = create AwardObject
end

Given /^the Award Modifier creates an Award with an obligated amount and blank project start date$/ do
  steps '* I log in with the Award Modifier user'
  @award = create AwardObject, project_start_date: ''
end

When /^the Award Modifier creates an Award with a project start date later than the obligation start date$/ do
  steps '* I log in with the Award Modifier user'
  @award = create AwardObject, project_start_date: next_week[:date_w_slashes]
end