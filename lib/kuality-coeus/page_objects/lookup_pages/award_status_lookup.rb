class AwardStatusLookup < Lookup

  element(:status_code) { |b| b.frm.text_field(name: 'statusCode') }
  element(:description) { |b| b.frm.text_field(name: 'description') }

end