class CentralAdmin < BasePage

  page_url "#{$base_url+$context}portal.do?selectedTab=portalCentralAdminBody"

  green_buttons create_award: 'Award', create_proposal_log: 'Proposal Log',
                create_institutional_proposal: 'Institutional Proposal', create_subaward: 'Subawards'

end