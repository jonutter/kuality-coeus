class Maintenance < BasePage

  page_url "#{$base_url+$context}portal.do?selectedTab=portalMaintenanceBody"

  links 'Institute Rate', 'Sponsor', 'Unit Administrator', 'Budget Editable Columns',
        'Sponsor Template', 'Sponsor Terms'


end