class CampusLookup < Lookups

  element(:campus_code) { |b| b.frm.text_field(name: 'code') }
  element(:campus_name) { |b| b.frm.text_field(name: 'name') }
  element(:campus_short_name) { |b| b.frm.text_field(name: 'shortName') }
  element(:campus_type_code) { |b| b.frm.select(name: 'campusTypeCode') }
  action(:campus_type_code_lookup) { |b| b.frm.select(name: 'methodToCall.performLookup.(!!org.kuali.rice.location.impl.campus.CampusTypeBo!!).(((code:campusTypeCode))).((`campusTypeCode:code`)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;https://qa.research.rsmart.com:/kc-dev/kr/lookup.do;::::).anchor').click }
  #TODO: Define 'yes, no, both' options for Active Indicator

end