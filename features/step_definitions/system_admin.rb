And /^the (.*) parameter is set to (.*)$/ do |parameter, value|
  $users.admin.sign_in unless $users.admin.logged_in?
  visit(SystemAdmin).parameter
  on ParameterLookup do |look|
    look.parameter_name.set parameter
    look.search
    look.edit_item parameter
  end
  on ParameterMaintenanceDocument do |page|
    unless page.parameter_value.value==parameter
      page.parameter_value.set(value)
      page.description.set random_alphanums
      page.blanket_approve
    end
  end
end