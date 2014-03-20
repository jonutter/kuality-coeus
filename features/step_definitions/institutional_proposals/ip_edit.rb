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
  steps %q{ * I log in with the Institutional Proposal Maintainer user }
  @institutional_proposal.view :@institutional_proposal
  on(InstitutionalProposal).edit
  # Pick a field at random for the test...
  @required_field = ['Project Period', 'Cost Share Type', 'Source Account', 'Commitment Amount'
  ].sample
  # Properly set the nil value depending on the field type...
  @required_field=~/Type/ ? value='select' : value=' '
  # Transform the field name to the appropriate symbol...
  field = damballa(@required_field)
  @institutional_proposal.add_cost_sharing field=>value
end

When(/^the Institutional Proposal Maintainer enters invalid characters for a cost sharing element$/) do
  steps %q{ * I log in with the Institutional Proposal Maintainer user }
  @institutional_proposal.view :@institutional_proposal
  on(InstitutionalProposal).edit
  @required_field = [ 'Project Period', 'Percentage', 'Amount' ].sample
  field = damballa(@required_field)
  @institutional_proposal.add_cost_sharing field=>random_letters
end

When(/^the Institutional Proposal Maintainer adds an unrecovered f&a element with a missing required field$/) do
  steps %q{ * I log in with the Institutional Proposal Maintainer user }
  @institutional_proposal.view :@institutional_proposal
  on(InstitutionalProposal).edit
  # Pick a field at random for the test...
  @required_field = ['Fiscal Year', 'Rate Type', 'Source Account', 'Amount'
  ].sample
  # Properly set the nil value depending on the field type...
  @required_field=~/Type/ ? value='select' : value=' '
  # Transform the field name to the appropriate symbol...
  field = damballa(@required_field)
  @institutional_proposal.add_unrecovered_fa field=>value
end

When(/^the Institutional Proposal Maintainer enters invalid characters for an unrecovered f&a element$/) do
  steps %q{ * I log in with the Institutional Proposal Maintainer user }
  @institutional_proposal.view :@institutional_proposal
  on(InstitutionalProposal).edit
  @required_field = [ 'Fiscal Year', 'Applicable Rate', 'Amount' ].sample
  field = damballa(@required_field)
  @institutional_proposal.add_unrecovered_fa field=>random_letters
end

When(/^the Institutional Maintainer enters an invalid year for the fiscal year field$/) do
  steps %q{ * I log in with the Institutional Proposal Maintainer user }
  @institutional_proposal.view :@institutional_proposal
  on(InstitutionalProposal).edit
  @institutional_proposal.add_unrecovered_fa :fiscal_year => '00'
end