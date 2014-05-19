When /^the (.*) user creates an IRB Protocol$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @irb_protocol = create IRBProtocolObject
end

When /^the Protocol Creator user creates a Protocol with an invalid lead unit code$/ do
  steps %{ * I log in with the Protocol Creator user }
  @irb_protocol = create IRBProtocolObject, :lead_unit=>'000000'
end

When /^the Protocol Creator creates an IRB Protocol but misses a required field$/ do
  steps %{ * I log in with the Protocol Creator user }
  # Pick a field at random for the test...
  required_field = ['Description', 'Title', 'Lead Unit'
          ].sample
  field = damballa(required_field)
  @irb_protocol = create IRBProtocolObject, field=>''
  text = ' is a required field.'
  errors = {
      description: "Document Description (Description)#{text}",
      title: "Title (Title)#{text}",
      lead_unit: "#{required_field} (#{required_field})#{text}"
  }
  @required_field_error = errors[field]
end