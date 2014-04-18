class AwardLookup < Lookups

  url_info 'Award','kra.award.home.Award'

  element(:award_id) { |b| b.frm.text_field(name: 'awardNumber') }

  value(:award_ids) { |b|
    ids=[]
    b.results_table.trs.each { |row| ids << row.tds[1].text.strip }
    ids.delete_at(0)
    ids
  }

end