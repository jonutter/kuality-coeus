class UnitLookup < Lookups

  url_info 'Unit','kra.bo.Unit'

  element(:page_links) { |b| b.frm.span(class: 'pagelinks').links }

end