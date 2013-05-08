class FinancialEntities < BasePage

  global_buttons

  class << self

    def financial_entities_tabs
      buttons 'Reporter', 'New Financial Entity', 'My Financial Entities'
    end

  end

end