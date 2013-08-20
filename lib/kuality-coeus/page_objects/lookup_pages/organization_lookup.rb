class OrganizationLookup < Lookups
  
  element(:organization_id) { |b| b.frm.text_field(name: 'organizationId') }
  
end