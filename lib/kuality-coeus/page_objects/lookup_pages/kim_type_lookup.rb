class KimTypeLookup < Lookups

  element(:namespace_code) { |b| b.frm.select(name: 'namespaceCode') }
  element(:type_name) { |b| b.frm.text_field(name: 'name') }
  
end