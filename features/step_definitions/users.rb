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
Given /^I log in with the (.*) user$/ do |role|
  get(role).sign_in
end

# This step definition
# 1) Assumes you're already logged in with a user with admin privileges
# 2) Creates the user object in a class instance variable based on the user name
# 3) Creates the user in the system if they don't exist already
Given /^I have a user with the user name (.*)$/ do |username|
  user = make_user username
  user.create unless user.exists?
end

# This step definition will return a user with
# the specified role. If there are multiple matching
# users, it will select one of them randomly, and create
# them if they don't exist in the system.
Given /^I have a user with the system role: '(.*)'$/ do |role|
  user = make_role role
  # TODO: Need to make this more robust--because what happens if
  # You're logged in with a user who doesn't have rights to
  # create new users?
  user.create unless user.exists?
end

Then /^(.*) is logged in$/ do |username|
  get(username).logged_in?
end

Given /^I have users with the following roles: (.*)$/ do |roles|
  roles.split(', ').each do |r|
    user = make_role r
    user.create unless user.exists?
  end
end

Given /^I have a user that can be a PI for Grants.gov proposals$/ do
  # TODO: Make this more robust when we really know what it takes
  # to be a grants.gov PI...
  @grants_gov_pi = make_user 'grantsgov'
end