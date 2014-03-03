And /^I? ?activate a validation check$/ do
  on(Proposal).proposal_actions
  on ProposalActions do |page|
    page.show_data_validation
    page.turn_on_validation
  end
end

When /^the Proposal has no principal investigator$/ do
  #nothing needed for this step
end

When /^I? ?do not answer my proposal questions$/ do
  #nothing necessary for this step
end

When /^(the (.*) |)creates a Proposal with an un-certified (.*)$/ do |text, role_name, role|
  steps %{ * I log in with the #{role_name} user } unless text == ''
  @role = role
  @proposal = create ProposalDevelopmentObject
  @proposal.add_key_person role: @role, certified: false
end

Given /^(the (.*) |)creates a Proposal where the un-certified key person has included certification questions$/ do |text, role_name|
  steps %{ * I log in with the #{role_name} user } unless text == ''
  @role = 'Key Person'
  @proposal = create ProposalDevelopmentObject
  @proposal.add_key_person role: @role, key_person_role: 'default', certified: false
end