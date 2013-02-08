class Researcher < BasePage

  page_url "#{$base_url}selectedTab=portalResearcherBody"

  frame_element

  action(:create_proposal) { |b| b.link(title: "Create Proposal").click }

end