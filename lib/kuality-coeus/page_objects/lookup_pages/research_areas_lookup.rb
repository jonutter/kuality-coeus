class ReasearchAreasLookup < Lookups

  element(:research_area_code) { |b| b.frm.text_field(name: 'researchAreaCode') }
  element(:parent_research_area_code) { |b| b.frm.text_field(name: 'parentResearchAreaCode') }

  element(:research_area_code_description) { |b| b.frm.text_field(name: 'description') }
end