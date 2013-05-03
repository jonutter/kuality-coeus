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
#    based on the username
# 3) Assumes that username user already exists in the system
# 4) Logs that user in, if they're not already
Given /^I log in with (.*)$/ do |username|
  get(username).sign_in
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
Given /^I have a user with a role of '(.*)'$/ do |role|
  user = make_role role
  user.create unless user.exists?
end

Then /^(.*) is logged in$/ do |username|
  get(username).logged_in?
end
