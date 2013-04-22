class SystemAdmin < BasePage

  page_url "#{$base_url}selectedTab=portalSystemAdminBody"

  action(:person) { |b| b.frm.link(text: 'Person').click }

end