When /^a special review item is added to the Proposal with an approval date earlier than the application date$/ do
  @proposal.add_special_review approval_date: yesterday[:date_w_slashes], application_date: in_a_week[:date_w_slashes]
end

And /adds a special review item to the Proposal$/ do
  @proposal.add_special_review
end