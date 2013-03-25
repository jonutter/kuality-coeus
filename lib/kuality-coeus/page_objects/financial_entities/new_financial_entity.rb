class NewFinancialEntity < FinancialEntities

  financial_entities_tabs

  element(:entity_name) { |b| b.frm.text_field(id: 'financialEntityHelper.newPersonFinancialEntity.entityName') }
  element(:address_line_1) { |b| b.frm.text_field(id: 'financialEntityHelper.newPersonFinancialEntity.finEntityContactInfos[0].addressLine1') }
  element(:city) { |b| b.frm.text_field(id: 'financialEntityHelper.newPersonFinancialEntity.finEntityContactInfos[0].city') }
  element(:country_code) { |b| b.frm.select(id: 'financialEntityHelper.newPersonFinancialEntity.finEntityContactInfos[0].countryCode') }
  element(:postal_code) { |b| b.frm.text_field(id: 'financialEntityHelper.newPersonFinancialEntity.finEntityContactInfos[0].postalCode') }
  element(:type) { |b| b.frm.select(id: 'financialEntityHelper.newPersonFinancialEntity.entityTypeCode') }
  element(:status_code) { |b| b.frm.select(id: 'financialEntityHelper.newPersonFinancialEntity.statusCode') }
  element(:held) { |b| b.frm.select(id: 'financialEntityHelper.newPersonFinancialEntity.entityOwnershipType') }
  
end