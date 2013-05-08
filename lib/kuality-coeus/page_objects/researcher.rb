class Researcher < BasePage

  page_url "#{$base_url}portal.do?selectedTab=portalResearcherBody"

  links 'Create Proposal', 'All My Proposals'

  element(:error_table) { |b| b.frm.table(class: 'container2') }
  
end