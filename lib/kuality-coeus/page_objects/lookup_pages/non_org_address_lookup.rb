class NonOrgAddressBookLookup < Lookups

  alias_method :select_person, :check_item

  value(:returned_full_names) { |b|
    names=[]
    b.results_table.trs.each { |row|
      names << "#{row.tds[13].text.strip} #{row.tds[14].text.strip}"
    }
    2.times{names.delete_at(0)}
    names
  }

end