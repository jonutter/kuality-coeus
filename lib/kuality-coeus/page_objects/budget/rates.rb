class Rates < BudgetDocument

  glbl 'Sync All Rates', 'Reset All Rates'

  action(:applicable_rate) { |desc, on_camp, f_yr, b| b.frm.tr(/^#{desc}.#{on_camp}.#{f_yr}/m).text_field(title: '* Applicable Rate') }
  
end