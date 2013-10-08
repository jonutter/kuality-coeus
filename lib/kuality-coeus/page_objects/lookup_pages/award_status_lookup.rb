class AwardStatusLookup < Lookups

  element(:status_code) { |b| b.frm.text_field(name: 'statusCode') }

end