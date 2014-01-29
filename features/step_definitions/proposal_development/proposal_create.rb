Given /^the (.*) creates a Proposal$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @proposal = create ProposalDevelopmentObject
end

Given /^the (.*) creates a second Proposal$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @proposal2 = create ProposalDevelopmentObject
end

Given /^the (.*) creates a (\d+)-year project Proposal$/ do |role_name, year_count|
  steps %{ * I log in with the #{role_name} user }
  @years=year_count.to_i
  @proposal =create ProposalDevelopmentObject,
                    project_start_date: "01/01/#{next_year[:year]}",
                    project_end_date: "12/31/#{next_year[:year].to_i+(@years-1)}"
end

Given /^the (.*) creates a (\d+)-year, '(.*)' Proposal$/ do |role_name, year_count, activity_type|
  steps %{ * I log in with the #{role_name} user }
  @years=year_count.to_i
  @proposal =create ProposalDevelopmentObject,
                    project_start_date: "01/01/#{next_year[:year]}",
                    project_end_date: "12/31/#{next_year[:year].to_i+(@years-1)}",
                    activity_type: activity_type
end

When /^the (.*) attempts to create a Proposal while missing a required field$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  # Pick a field at random for the test...
  @required_field = ['Description', 'Proposal Type', 'Activity Type',
           'Project Title', 'Sponsor Code', 'Project Start Date', 'Project End Date'
          ].sample
  # Properly set the nil value depending on the field type...
  @required_field=~/Type/ ? value='select' : value=''
  # Transform the field name to the appropriate symbol...
  field = snake_case(@required_field)
  @proposal = create ProposalDevelopmentObject, field=>value
end

When /^the (.*) creates a Proposal with an? '(.*)' sponsor type$/ do |role_name, type|
  steps %{ * I log in with the #{role_name} user }
  @proposal = create ProposalDevelopmentObject, sponsor_type_code: type
end

Given /^the (.*) creates a Proposal with (\D+) as the sponsor$/ do |role_name, sponsor_name|
  steps %{ * I log in with the #{role_name} user }
  # First, we have to get the sponsor ID based on the sponsor_name string...
  visit(Maintenance).sponsor
  sponsor_code=''
  on SponsorLookup do |search|
    search.sponsor_name.set sponsor_name
    search.search
    sponsor_code = search.get_sponsor_code(sponsor_name)
  end
  # Now we can create the proposal with the proper sponsor ID...
  @proposal = create ProposalDevelopmentObject, sponsor_id: sponsor_code
end

Given /^the (.*) creates a Proposal with a type of '(.*)'$/ do |role_name, type|
  steps %{ * I log in with the #{role_name} user }
  @proposal = create ProposalDevelopmentObject, proposal_type: type
end

When /^the (.*) creates a Proposal with an invalid sponsor code$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @proposal = create ProposalDevelopmentObject, :sponsor_id=>'000000'
end

Given /^the (.*) creates a Proposal without a sponsor deadline date$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @proposal = create ProposalDevelopmentObject, sponsor_deadline_date: ''
end

Then /^I should see an error that says a valid sponsor code is required$/ do
  on(Proposal).errors.should include 'A valid Sponsor Code (Sponsor) must be selected.'
end

When /^the (.*) submits the Proposal into routing$/ do |role_name|
  steps %{ * I log in with the #{role_name} user }
  @proposal.submit
end

When /^I? ?completes? the Proposal$/ do
  @proposal.add_principal_investigator
  @proposal.set_valid_credit_splits
  @proposal.add_custom_data
end

When /completes? the required custom fields on the Proposal$/ do
  @proposal.add_custom_data
end

When /^I? ?add (.*) as an? (.*) to the proposal permissions$/ do |username, role|
  @proposal.permissions.send("#{snake_case(role)}s") << username
  @proposal.permissions.assign
end

When /^I? ?save and close the Proposal document$/ do
  @proposal.close
  on(Confirmation).yes
end

And /^the (.*) submits a new Proposal into routing$/ do |role_name|
  steps %{
    * I log in with the #{role_name} user
    * the Proposal Creator creates a Proposal
    * add a principal investigator to the Proposal
    * set valid credit splits for the Proposal
    * complete the required custom fields on the Proposal
    * submit the Proposal
}
end

And /^the (.*) completes the remaining required actions for an S2S submission$/ do |role_name|
  steps %{
    * I log in with the #{role_name} user
    * sets valid credit splits for the Proposal
    * add and mark complete all the required attachments
    * create a final and complete Budget Version for the Proposal
    * complete the required custom fields on the Proposal
    * answer the S2S questions
        }
end

And /^I? ?adds? the (Grants.Gov|Research.Gov) opportunity id of (.*) to the Proposal$/ do |type, op_id|
  @proposal.edit opportunity_id: op_id
  on(Proposal).s2s
  on S2S do |page|
    page.expand_all
    page.s2s_lookup




    sleep 50





  end
  on OpportunityLookup do |look|
    look.s2s_provider.select type
    look.search
    look.return_value op_id
  end
  on(S2S).save
end

And /^I? ?adds? the (Grants.Gov|Research.Gov) opportunity, id: (.*), competition id: (.*)$/ do |type, op_id, comp_id|
  @proposal.edit opportunity_id: op_id
  on(Proposal).s2s
  on S2S do |page|
    page.expand_all
    page.s2s_lookup
  end
  on OpportunityLookup do |look|
    look.s2s_provider.select type
    look.search
    look.return_value comp_id
  end
  on(S2S).save
end

And /^I? ?adds? and marks? complete all the required attachments for an NSF Proposal$/ do
  %w{Equipment Bibliography BudgetJustification ProjectSummary Narrative}.shuffle.each do |type|
    @proposal.add_proposal_attachment type: type, file_name: 'test.pdf', status: 'Complete'
  end
  @proposal.add_proposal_attachment type: 'Other', file_name: 'NSF_DATA_MANAGEMENT_PLAN.pdf', status: 'Complete', description: random_alphanums
  @proposal.key_personnel.each do |person|
    %w{Biosketch Currentpending}.each do |type|
      @proposal.add_personnel_attachment person: person.full_name, type: type, file_name: 'test.pdf'
    end
  end
end

Then /^I should see an error that says the field is required$/ do
  text="#{@required_field} is a required field."
  @required_field=='Description' ? error='Document '+text : error=text
  on(Proposal) do |page|
    page.error_summary.wait_until_present(5)
    page.errors.should include error
  end
end

Given /^the (.*) user creates? a Proposal with these Performance Site Locations: (.*)$/ do |role_name, psl|
  steps %{ * I log in with the #{role_name} user }
  locations = psl.split(',')
  @proposal = create ProposalDevelopemntObject, performance_site_locations: locations
end