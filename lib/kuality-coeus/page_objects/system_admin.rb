class SystemAdmin < BasePage

  page_url "#{$base_url}portal.do?selectedTab=portalSystemAdminBody"

  links 'Person', 'Person Extended Attributes', 'Group', 'Role'

end