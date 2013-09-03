When /^I? ?create a group$/ do
  @group = create GroupObject
end

When /^I? ?add the user to the group$/ do
  @group.add_assignee member_identifier: @user.principal_id
end