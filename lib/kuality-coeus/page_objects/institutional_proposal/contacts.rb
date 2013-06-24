class IPContacts < KCInstitutionalProposal

  inst_prop_header_elements

  # Combined Credit Split
  {
      'recognition'=>1,
      'responsibility'=>2,
      'space'=>3,
      'financial'=>4
  }.each do |key, value|
    # Makes methods for the person's 3 credit splits (doesn't have to take the full name of the person to work)
    # Example: page.responsibility('Joe Schmoe').set '100.00'
    action(key.to_sym) { |name, b| b.credit_split_div_table.row(text: /#{name}/)[value].text_field }
    # Makes methods for the person's units' credit splits
    # Example: page.unit_financial('Jane Schmoe', 'Unit').set '50.0'
    action("unit_#{key}".to_sym) { |full_name, unit_name, p| p.target_unit_row(full_name, unit_name)[value].text_field }
  end

  # =======
  private
  # =======

  element(:credit_split_div_table) { |b| b.frm.h3(text: 'Combined Credit Split').parent.table }

  action(:target_unit_row) do |full_name, unit_number, p|
    trows = p.credit_split_div_table.rows
    index = trows.find_index { |row| row.text=~/#{full_name}/ }
    trows[index..-1].find { |row| row.text=~/#{unit_number}/ }
  end

end