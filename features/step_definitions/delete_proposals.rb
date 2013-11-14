When /^I delete the Proposal$/ do
  @proposal.delete
end

Then /^The Proposal is deleted$/ do
  @proposal.status.should == 'CANCELED'
  @proposal.view
  on(Proposal).error_message.should == 'The Development Proposal has been deleted.'
end