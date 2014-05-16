class SystemAdmin < BasePage

  page_url "#{$base_url+$context}portal.do?selectedTab=portalSystemAdminBody"

  links 'Person', 'Person Extended Attributes', 'Group', 'Role', 'Parameter'

end