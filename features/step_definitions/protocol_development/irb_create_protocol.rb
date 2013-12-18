When(/^I? ?creates? an irb protocol$/) do
  @irb_protocol = create IRBProtocolDevelopmentObject
end
When(/^I? ?creates? a proposal with an invalid lead unit code$/) do
  @irb_protocol = create IRBProtocolDevelopmentObject, :lead_unit=>'000000'
end
Then(/^I should see an error that says my lead unit code is invalid$/) do
  on(ProtocolOverview).errors.should include 'Lead Unit is invalid.'
end

# Note: I created this step, in addition to create_proposal.rb, Line: 143 because
# the errors on this page are lame and include the name of the field twice.
# ex. "Doc Description (Description) is required."
Then /^an error should appear that says the field is required$/ do
  text="#{@required_field} (#{@required_field}) is a required field."
  @required_field=='Description' ? error='Document '+text : error=text
  on(ProtocolOverview).errors.should include error
end

When(/^I? ?create? an irb protocol but I miss a required field$/) do
  # Pick a field at random for the test...
  @required_field = ['Description', 'Title', 'Lead Unit'
          ].sample
  # Properly set the nil value depending on the field type...
  @required_field= value=''
  # Transform the field name to the appropriate symbol...
  field = snake_case(@required_field)
  @irb_protocol = create IRBProtocolDevelopmentObject, field=>value
end