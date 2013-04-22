Given /^I have a user with the user name (.*)$/ do |username|
  instance_variable_set('@'+username, (make UserObject, user: username))
  user = instance_variable_get('@'+username)
  user.create unless user.exists?
end