class AwardLookup < Lookups

  element(:award_id) { |b| b.frm.text_field(name: 'awardNumber') }

end