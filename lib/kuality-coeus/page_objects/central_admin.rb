class CentralAdmin < BasePage

  page_url "#{$base_url}selectedTab=portalCentralAdminBody"

  action(:create_committee) { |b| b.link(title: "Create Committeee").click }

end