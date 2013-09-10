When /^create a role with permission to create proposals$/ do
  @role = create RoleObject, permissions: ['842']
end

When /^I? ?add the group to the role$/ do
  @role.add_assignee type_code: 'Group', member_identifier: @group.id
end