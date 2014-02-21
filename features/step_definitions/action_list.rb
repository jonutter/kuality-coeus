When /^I visit the action list outbox$/ do
  visit(ActionList).outbox
end

Then /^the (principal investigator|OSPApprover) can access the Proposal from their action list$/ do |user|
  if user=='OSPApprover'
    steps '* I log in with the OSPApprover user'
  else
    steps '* I log in with the principal investigator'
  end
  expect {
    visit(ActionList).filter
    on ActionListFilter do |page|
      page.document_title.set @proposal.project_title
      page.filter
    end
    on(ActionList).open_item(@proposal.document_id)
  }.not_to raise_error
end

When /^I filter the Award from my action list$/  do
  visit(ActionList).filter
  on ActionListFilter do |page|
    page.document_title.set "KC Award - #{@award.description}"
    page.filter
  end
end

Then /^I should see my Award listed with the action requested status: (.*)$/ do |action_requested|
 on(ActionList).action_requested(@award.document_id).should == action_requested
end