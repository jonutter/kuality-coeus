class CentralAdmin < BasePage

  page_url "#{$base_url}portal.do?selectedTab=portalCentralAdminBody"

  links 'Create Committee'

  action(:create_award) { |b| b.frm.link(title: 'Award').click; b.loading }

end