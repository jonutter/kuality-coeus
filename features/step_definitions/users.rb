# We need this step def because of the special case of
# the admin user. Its data object is already created
# and added to the Users collection at the start of the
# scripts.
Given /^I'm( signed)? in as the admin$/ do |x|
  $users.admin.sign_in
end

# Note the difference between the following three
# step definitions...

# This step definition is a bit dangerous
# 1) Assumes that the user already exists in the system
# 2) Assumes the user object does not exist, so it creates it, sticking it into
#    a class instance variable based on the username
# 3) Logs that user in (if they're not already)...
Given /^I'm logged in with (.*)$/ do |username|
  make_user(user: username).sign_in
end

# Whereas, this step def
# 1) Assumes the user OBJECT already exists
# 2) Assumes the user object is contained in a class instance variable
#    based on the role
# 3) Assumes that role user already exists in the system
# 4) Logs that user in, if they're not already
Given /^I? ?log in with the (.*) user$/ do |role|
  get(role).sign_in
end

# This step definition
# 1) Creates the user object in a class instance variable based on the user name
# 2) Creates the user in the system if they don't exist already,
#    by first logging in with the admin user
Given /^a user exists with the user name (.*)$/ do |username|
  user = make_user user: username
  user.create unless user.exists?
end

# This step definition will return a user with
# the specified role. If there are multiple matching
# users, it will select one of them randomly, and create
# them if they don't exist in the system (again by first
# logging in with the admin user to do the creation).
Given /^a user exists with the system role: '(.*)'$/ do |role|
  user = make_user role: role
  user.create unless user.exists?
end

Then /^(.*) is logged in$/ do |username|
  get(username).logged_in?.should be true
end

Given /^users exist with the following roles: (.*)$/ do |roles|
  roles.split(', ').each do |r|
    user = make_user role: r
    user.create unless user.exists?
  end
end

Given /^a user exists that can be a PI for Grants.gov proposals$/ do
  make_user(user: UserObject::USERS.grants_gov_pi, type: 'Grants.gov PI')
  $users[-1].create unless $users[-1].exists?
end

Given /^an AOR user exists$/ do
  # TODO: Using the username here is cheating. Fix this.
  @aor = make_user(user: 'warrens', type: 'AOR')
  @aor.create unless @aor.exists?
end

When /^I? ?create an? '(.*)' user$/ do |type|
  $users << create(UserObject, type: type)
end

Given /^I? ?create a user with an? (.*) role in the (.*) unit$/ do |role, unit|
  role_num = RoleObject::ROLES[role]
  $users << create(UserObject, rolez: [{ id: role_num, name: role, qualifiers: [{:unit=>unit}] }] )
end

Given /^I? ?log in as the user with the (.*) role in (.*)$/ do |role, unit|
  $users.with_role_in_unit(role, unit).sign_in
end

When /^I? ?log in with that user$/ do
  $users[-1].sign_in
end

And /^I add the (.*) role in the (.*) unit to that user$/ do |role, unit|
  role_num = RoleObject::ROLES[role]
  $users[-1].add_role id: role_num, name: role, qualifiers: [{:unit=>unit}], user_name: $users[-1].user_name
end

# Use this step def when you know the role doesn't take a qualifier
And /^I add the (.*) role to that user$/ do |role|
  role_num = RoleObject::ROLES[role]
  $users[-1].add_role id: role_num, name: role, qualifiers: [], user_name: $users[-1].user_name
end