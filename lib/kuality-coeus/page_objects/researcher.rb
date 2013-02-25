class Researcher < BasePage

  page_url "#{$base_url}selectedTab=portalResearcherBody"

  action(:create_proposal) { |b| b.frm.link(title: 'Create Proposal').click }
  action(:all_my_proposals) { |b| b.frm.link(text: 'All My Proposals').click }

end