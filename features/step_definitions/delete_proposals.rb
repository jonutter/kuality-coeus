When /^I delete the proposal$/ do
  @proposal.delete
end
Then /^The proposal is deleted$/ do
  @proposal.status.should == 'CANCELED'
  @proposal.view #TODO Need this method
  on(Proposal).error_message.should == 'The Development Proposal has been deleted.'
end