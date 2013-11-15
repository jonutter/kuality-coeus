class Researcher < BasePage

  page_url "#{$base_url}portal.do?selectedTab=portalResearcherBody"

  links 'Create Proposal', 'All My Proposals', 'Search Proposals', 'Create IRB Protocol', 'Search Proposal Log',
        'Search Institutional Proposals'

  element(:error_table) { |b| b.frm.table(class: 'container2') }
  
end