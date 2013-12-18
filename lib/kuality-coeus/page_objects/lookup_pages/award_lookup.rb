class AwardLookup < Lookups

  url_info 'Award','kra.award.home.Award'

  element(:award_id) { |b| b.frm.text_field(name: 'awardNumber') }

end