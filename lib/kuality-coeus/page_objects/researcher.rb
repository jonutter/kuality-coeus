class Researcher < BasePage

  page_url "#{$base_url}portal.do?selectedTab=portalResearcherBody"

  action(:create_proposal) { |b| b.frm.link(title: 'Create Proposal').click }
  action(:all_my_proposals) { |b| b.frm.link(text: 'All My Proposals').click }

  element(:error_table) { |b| b.frm.table(class: 'container2') }
  
end