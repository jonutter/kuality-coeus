class BudgetDocument < BasePage

  budget_header_elements
  global_buttons
  document_header_elements
  error_messages
  tab_buttons

  class << self

    def select_budget_period
      element(:budget_period) { |b| b.frm.select(name: 'viewBudgetPeriod') }
      element(:view) { |b| b.frm.select(name: 'viewBudgetView') }
      action(:update_view) { |b| b.frm.button(title: 'Update View').click }
    end

  end

end