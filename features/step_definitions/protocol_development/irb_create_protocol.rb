When /^the (.*) user creates an irb protocol$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @irb_protocol = create IRBProtocolDevelopmentObject
end

When /^the (.*) user creates a proposal with an invalid lead unit code$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @irb_protocol = create IRBProtocolDevelopmentObject, :lead_unit=>'000000'
end

When /^the (.*) user creates an irb protocol but I miss a required field$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  # Pick a field at random for the test...
  required_field = ['Description', 'Title', 'Lead Unit'
          ].sample
  field = damballa(required_field)
  @irb_protocol = create IRBProtocolDevelopmentObject, field=>''
  text = ' is a required field.'
  errors = {
      description: "Document Description (Description)#{text}",
      title: "Title (Title)#{text}",
      lead_unit: "#{required_field} (#{required_field})#{text}"
  }
  @required_field_error = errors[field]
end