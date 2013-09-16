When /^create a role with permission to create proposals$/ do
  role = make_role permissions: %w{842}
  role.create
end

When /^I? ?add the group to the role$/ do
  @role.add_assignee type_code: 'Group', member_identifier: @group.id
end

When /^the '(.*)' role exists$/ do |role|
  make_role name: role
  get(role).create unless get(role).exists?
end

When /^I? ?add the group to the '(.*)' role$/ do |role|
  get(role).add_assignee type_code: 'Group', member_identifier: @group.id
end