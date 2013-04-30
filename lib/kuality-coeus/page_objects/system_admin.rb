class SystemAdmin < BasePage

  page_url "#{$base_url}portal.do?selectedTab=portalSystemAdminBody"

  action(:person) { |b| b.frm.link(text:'Person').click }

end