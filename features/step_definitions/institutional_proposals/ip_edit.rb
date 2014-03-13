# Don't parameterize this unless and until it's necessary...
When /^the Institutional Proposal Maintainer edits the Institutional Proposal$/ do
  steps '* I log in with the Institutional Proposal Maintainer user'
  @institutional_proposal.edit
end

And /^the Funding Proposal version should be '(\d+)'$/ do |version|
  @institutional_proposal.view :@institutional_proposal
  on InstitutionalProposal do |page|
    page.expand_all
    page.version.should==version
  end
end

When(/^the Institutional Proposal Maintainer adds a cost sharing element with a missing required field$/) do
  # Note that this step implicitly requires creation of a Proposal Log first...
  steps %q{ * I log in with the Institutional Proposal Maintainer user }
  # Pick a field at random for the test...
  @required_field = ['Project Period', 'Cost Share Type', 'Source Account', 'Amount'
  ].sample
  # Properly set the nil value depending on the field type...
  @required_field=~/Type/ ? value='select' : value=' '
  # Transform the field name to the appropriate symbol...
  field = damballa(@required_field)
  @institutional_proposal.add_cost_sharing field=>value
end