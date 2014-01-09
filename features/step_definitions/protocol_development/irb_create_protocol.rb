When(/^I? ?creates? an irb protocol$/) do
  @irb_protocol = create IRBProtocolDevelopmentObject
end
When(/^I? ?creates? a proposal with an invalid lead unit code$/) do
  @irb_protocol = create IRBProtocolDevelopmentObject, :lead_unit=>'000000'
end
Then(/^I should see an error that says my lead unit code is invalid$/) do
  on(ProtocolOverview).errors.should include 'Lead Unit is invalid.'
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