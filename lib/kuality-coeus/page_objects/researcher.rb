class Researcher < BasePage

  page_url "#{$base_url}selectedTab=portalResearcherBody"

  action(:create_proposal) { |b| b.frm.link(text: "Create Proposal").click }

end