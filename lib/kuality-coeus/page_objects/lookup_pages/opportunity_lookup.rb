class OpportunityLookup < Lookups

  url_info 'Grants.gov%20Opportunity%20Lookup','kra.s2s.bo.S2sOpportunity'

  element(:s2s_provider) { |b| b.frm.select(id: 'providerCode') }
  element(:opportunity_id) { |b| b.frm.text_field(id: 'opportunityId') }
  
end