class GroupLookup < Lookups

  url_info 'Group','rice.kim.impl.group.GroupBo'

  element(:group_id) { |b| b.frm.text_field(name: 'id') }
  
end