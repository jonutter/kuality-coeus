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

# TODO: This and the next step def need to be reworked in light of the new user stuff...
And /^I add (.*) (.*) as a (.*) to Key Personnel$/ do |fname, lname, proposal_role|
  @proposal.add_key_person first_name: fname, last_name: lname, role: proposal_role
end

When /^I add (.*) (.*) as a Key Person with a role of (.*)$/ do |fname, lname, kp_role|
  @proposal.add_key_person first_name: fname, last_name: lname, role: 'Key Person', key_person_role: kp_role
end

And /^I add a Key Person with a (.*) credit split of (.*)$/ do |cs_type, amount|
  @proposal.add_key_person cs_type.downcase.to_sym=>amount
end

# TODO: Rewrite this, as it will not work in the new test environment...
When /^I try to add two (.*)s$/ do |rol|
  [{first_name: 'Dick', last_name: 'Keogh', role: rol},
   {first_name: 'Pam', last_name: 'Brown', role: rol}]
  .each { |opts| @proposal.add_key_person opts }
end

When /^I submit the proposal$/ do
  @proposal.submit
end

When /^I complete the proposal$/ do
  @proposal.add_key_person
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