class OpportunityLookup < BasePage
  
  tiny_buttons
  search_results_table
  
  element(:s2s_provider) { |b| b.frm.select(id: 'providerCode') }
  element(:opportunity_id) { |b| b.frm.text_field(id: 'opportunityId') }
  
end