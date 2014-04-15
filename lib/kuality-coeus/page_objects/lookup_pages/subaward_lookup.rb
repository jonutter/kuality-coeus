class SubawardLookup < Lookups

  url_info 'Subawards', 'kra.subaward.bo.SubAward'

  element(:subaward_id) { |b| b.frm.text_field(name: 'subAwardCode') }
  
end
