Given /^the (.*) user submits the Funding Proposal$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @institutional_proposal.project_personnel << person
  @institutional_proposal.add_custom_data
  @institutional_proposal.set_valid_credit_splits
  on(IPContacts).institutional_proposal_actions
  on(InstitutionalProposalActions).submit
end

When /^(the (.*) user |)merges the temporary proposal log with the Funding Proposal$/ do |text, role_name|
  steps %{ * I log in with the #{role_name} user } unless text == ''
  visit(Researcher).search_proposal_log
  on ProposalLogLookup do |page|
    page.proposal_number.set @temp_proposal_log.number
    page.search
    page.merge_item(@temp_proposal_log.number)
  end
  on InstitutionalProposalLookup do |page|
    page.institutional_proposal_number.set @institutional_proposal.proposal_number
    page.search
    page.select_item(@institutional_proposal.proposal_number)
  end
end

When /^I merge the permanent proposal log with the institutional proposal$/ do
  pending
end

When /^the Create Proposal Log user creates an institutional proposal with a missing required field$/ do
  # Note that this step implicitly requires creation of a Proposal Log first...
  steps %q{ * I log in with the Create Proposal Log user }
  # Pick a field at random for the test...
  @required_field = ['Project Title', 'Description','Activity Type','Sponsor ID', 'Proposal Type'
  ].sample
  # Properly set the nil value depending on the field type...
  @required_field=~/Type/ ? value='select' : value=' '
  # Transform the field name to the appropriate symbol...
  field = damballa(@required_field)
  @institutional_proposal = create InstitutionalProposalObject, field=>value
end

Given (/^the admin user creates a sponsor template$/) do
  @sponsor_template = create SponsorTemplateObject
end