When /^I? ?create a group$/ do
  @group = create GroupObject
end

When /^I? ?add the user to the group$/ do
  # Note that this step is assuming you're adding the user that was
  # last created in the scenario...
  @group.add_assignee member_identifier: $users[-1].principal_id
end

Given /^I? ?add the group to the user$/ do
  $users[-1].add_group id: @group.id
end