class CentralAdmin < BasePage

  page_url "#{$base_url}selectedTab=portalCentralAdminBody"

  action(:create_committee) { |b| b.frm.link(title: 'Create Committeee').click }

end