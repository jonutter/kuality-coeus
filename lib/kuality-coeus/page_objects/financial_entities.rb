class FinancialEntities < BasePage

  global_buttons

  class << self

    def financial_entities_tabs
      button "Reporter"
      button "New Financial Entity"
      button "My Financial Entities"
    end

  end

end