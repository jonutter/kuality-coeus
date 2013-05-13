Given /^I initiate a proposal$/ do
  @proposal = create ProposalDevelopmentObject
end

Given /^I initiate a second proposal$/ do
  @proposal2 = create ProposalDevelopmentObject
end

Given /^I initiate a 5-year project proposal$/ do
  @proposal =create ProposalDevelopmentObject,
                    project_start_date: "01/01/#{next_year[:year]}",
                    project_end_date: "12/31/#{next_year[:year].to_i+5}"
end

When /^I initiate a proposal but miss a required field$/ do
  @name = ['Description', 'Proposal Type', 'Lead Unit', 'Activity Type',
           'Project Title', 'Sponsor Code', 'Project Start Date', 'Project End Date'
          ].sample
  @name=~/Type/ || @name=='Lead Unit' ? value='select' : value=''
  field = snake_case(@name)
  @proposal = create ProposalDevelopmentObject, field=>value
end

When /^I begin a proposal with a '(.*)' sponsor type$/ do |type|
  @proposal = create ProposalDevelopmentObject, sponsor_type_code: type
end

Then /^I should see an error that says the field is required$/ do
  text="#{@name} is a required field."
  @name=='Description' ? error='Document '+text : error=text
  on(Proposal) do |page|
    page.error_summary.wait_until_present(5)
    page.errors.should include error
  end
end

When /^I begin a proposal with an invalid sponsor code$/ do
  @proposal = create ProposalDevelopmentObject, :sponsor_code=>'000000'
end

Given /^I initiate a proposal without a sponsor deadline date$/ do
  @proposal = create ProposalDevelopmentObject, sponsor_deadline_date: ''
end

Then /^I should see an error that says a valid sponsor code is required$/ do
  on(Proposal).errors.should include 'A valid Sponsor Code (Sponsor) must be selected.'
end

When /^I submit the proposal$/ do
  @proposal.submit
end

When /^I complete the proposal$/ do
  @proposal.add_principal_investigator
  @proposal.set_valid_credit_splits
  @proposal.add_custom_data
  #opts={document_id: @proposal.document_id}
  #@proposal.kuali_u_questions = create KualiUniversityQuestionsObject, opts
  #@proposal.proposal_questions = create ProposalQuestionsObject, opts
  #@proposal.compliance_questions = create ComplianceQuestionsObject, opts
  #@proposal.s2s_questionnaire = create S2SQuestionnaireObject, opts
end

When /^I add (.*) as (a|an) (.*) to the proposal permissions$/ do |username, x, role|
  @proposal.permissions.send("#{snake_case(role)}s") << username
  @proposal.permissions.assign
end

When /^I save and close the proposal document$/ do
  @proposal.close
  on(Confirmation).yes
end