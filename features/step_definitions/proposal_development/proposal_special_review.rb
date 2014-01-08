When /^a special review item is added to the Proposal with an approval date earlier than the application date$/ do
  @proposal.add_special_review approval_date: yesterday[:date_w_slashes], application_date: in_a_week[:date_w_slashes]
end

Then /^I should see an error that the approval should occur later than the application$/ do
  on(SpecialReview).errors.should include 'Approval Date should be the same or later than Application Date.'
end
