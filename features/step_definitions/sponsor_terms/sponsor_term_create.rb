When /^the Application Administrator user submits a new Sponsor Term$/ do
  steps %{ * I log in with the Application Administrator user }
  @sponsor_term = create SponsorTermObject
end

When /^the Application Administrator user submits a new Sponsor Term with a missing required field$/ do
  steps %{ * I log in with the Application Administrator user }
  @required_field = ['Description', 'Sponsor Term Id', 'Sponsor Term Code',
                     'Sponsor Term Type Code', 'Sponsor Term Description'
  ].sample
  @required_field=~/(Type|Status)/ ? value='select' : value=' '
  field = damballa(@required_field)
  @sponsor_term = create SponsorTermObject, field=>value
end