And /^I initiate a proposal$/ do
  @proposal = create ProposalDevelopmentObject
end

When /^I begin a proposal without a (.*)$/ do |name|
  name=~/Type/ || name=='Lead Unit' ? value='select' : value=''
  field = StringFactory.damballa(name)
  @proposal = create ProposalDevelopmentObject, field=>value
end

Then /^I should see an error that says "(.* is a required field.)"$/ do |text|
  text=~/Description/ ? error='Document '+text : error=text
  on(Proposal) do |page|
    page.error_summary.wait_until_present(5)
    page.errors.should include error
  end
end

When /^I begin a proposal with an invalid sponsor code$/ do
  @proposal = create ProposalDevelopmentObject, :sponsor_code=>'000000'
end

Then /^I should see an error that says valid sponsor code required$/ do
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
  @proposal.permissions.send("#{StringFactory.damballa(role)}s") << username
  @proposal.permissions.assign
end

When /^I save and close the proposal document$/ do
  @proposal.close
  on(QuestionDialogPage).yes
end