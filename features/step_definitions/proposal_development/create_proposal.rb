Given /^I? ?initiate a proposal$/ do
  @proposal = create ProposalDevelopmentObject
end

Given /^I? ?initiate a second proposal$/ do
  @proposal2 = create ProposalDevelopmentObject
end

Given /^I? ?initiate a (\d+)-year project proposal$/ do |year_count|
  @years=year_count.to_i
  @proposal =create ProposalDevelopmentObject,
                    project_start_date: "01/01/#{next_year[:year]}",
                    project_end_date: "12/31/#{next_year[:year].to_i+(@years-1)}"
end

Given /^I? ?initiate a (\d+)-year, '(.*)' proposal$/ do |year_count, activity_type|
  @years=year_count.to_i
  @proposal =create ProposalDevelopmentObject,
                    project_start_date: "01/01/#{next_year[:year]}",
                    project_end_date: "12/31/#{next_year[:year].to_i+(@years-1)}",
                    activity_type: activity_type
end

When /^I? ?initiate a proposal but miss a required field$/ do
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

When /^I? ?initiate a proposal with an? '(.*)' sponsor type$/ do |type|
  @proposal = create ProposalDevelopmentObject, sponsor_type_code: type
end

Given /^I? ?initiate a proposal with (\D+) as the sponsor$/ do |sponsor_name|
  # First, we have to get the sponsor ID based on the sponsor_name string...
  visit(Maintenance).sponsor
  sponsor_code=''
  on SponsorLookup do |search|
    search.sponsor_name.set sponsor_name
    search.search
    sponsor_code = search.get_sponsor_code(sponsor_name)
  end
  # Now we can create the proposal with the proper sponsor ID...
  @proposal = create ProposalDevelopmentObject, sponsor_code: sponsor_code
end

Given /^I initiate a proposal with a type of '(.*)'$/ do |type|
  @proposal = create ProposalDevelopmentObject, proposal_type: type
end

When /^I? ?initiate a proposal with an invalid sponsor code$/ do
  @proposal = create ProposalDevelopmentObject, :sponsor_code=>'000000'
end

Given /^I? ?initiate a proposal without a sponsor deadline date$/ do
  @proposal = create ProposalDevelopmentObject, sponsor_deadline_date: ''
end

Then /^I should see an error that says a valid sponsor code is required$/ do
  on(Proposal).errors.should include 'A valid Sponsor Code (Sponsor) must be selected.'
end

When /^I? ?submit the proposal$/ do
  @proposal.submit
end

When /^I? ?complete the proposal$/ do
  @proposal.add_principal_investigator
  @proposal.set_valid_credit_splits
  @proposal.add_custom_data
end

When /^I? ?complete the required custom fields on the proposal$/ do
  @proposal.add_custom_data
end

When /^I? ?add (.*) as an? (.*) to the proposal permissions$/ do |username, role|
  @proposal.permissions.send("#{snake_case(role)}s") << username
  @proposal.permissions.assign
end

When /^I? ?save and close the proposal document$/ do
  @proposal.close
  on(Confirmation).yes
end

And /^I? ?submit a new development proposal into routing$/ do
  @proposal = create ProposalDevelopmentObject
  @proposal.add_principal_investigator
  @proposal.set_valid_credit_splits
  @proposal.add_custom_data
  @proposal.submit
end

And /^I? ?add the (Grants.Gov|Research.Gov) opportunity id of (.*) to the proposal$/ do |type, op_id|
  @proposal.edit opportunity_id: op_id
  on(Proposal).s2s
  on S2S do |page|
    page.expand_all
    page.s2s_lookup
  end
  on OpportunityLookup do |look|
    look.s2s_provider.select type
    look.search
    look.return_value op_id
  end
  on(S2S).save
end

And /^I? ?add the (Grants.Gov|Research.Gov) opportunity, id: (.*), competition id: (.*)$/ do |type, op_id, comp_id|
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

And /^I? ?add and mark complete all the required attachments for an NSF proposal$/ do
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