class UnitLookup < Lookups

  element(:page_links) { |b| b.frm.span(class: 'pagelinks').links }

end