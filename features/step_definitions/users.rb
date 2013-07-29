# Note the difference between the following three
# step definitions...

# This step definition
# 1) Assumes that the user already exists in the system
# 2) Assumes the user object does not exist, so it creates it, sticking it into
#    a class instance variable based on the username
# 3) Logs that user in (if they're not already)...
Given /^I'm logged in with (.*)$/ do |username|
  user = make_user username
  user.sign_in
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
  user = make_user username
  user.create unless user.exists?
end

# This step definition will return a user with
# the specified role. If there are multiple matching
# users, it will select one of them randomly, and create
# them if they don't exist in the system (again by first
# logging in with the admin user to do the creation).
Given /^a user exists with the system role: '(.*)'$/ do |role|
  user = make_role role
  user.create unless user.exists?
end

Then /^(.*) is logged in$/ do |username|
  get(username).logged_in?.should be true
end

Given /^users exist with the following roles: (.*)$/ do |roles|
  roles.split(', ').each do |r|
    user = make_role r
    user.create unless user.exists?
  end
end

Given /^a user exists that can be a PI for Grants.gov proposals$/ do
  # TODO: Make this more robust when we really know what it takes
  # to be a grants.gov PI...
  @grants_gov_pi = make_user UserObject::USERS.era_commons_user('grantsgov')
  @grants_gov_pi.create unless @grants_gov_pi.exists?
end

Given /^an AOR user exists$/ do
  # TODO: Using the quickstart user here is cheating. Fix this.
  @aor = make_user 'quickstart'
  @aor.create unless @aor.exists?
end