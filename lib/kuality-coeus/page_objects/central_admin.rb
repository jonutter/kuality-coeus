class CentralAdmin < BasePage

  header_tabs

  action(:create_committee) { |b| b.link(title: "Create Committeee").click }

end