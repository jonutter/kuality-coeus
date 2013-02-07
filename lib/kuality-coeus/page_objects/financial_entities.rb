class FinancialEntities < BasePage
  
  header_tabs
  global_buttons

  class << self

    def financial_entities_tabs
      action(:reporter) { |b| b.button(value: "Reporter").click }
      action(:new_financial_entity) { |b| b.button(value: "New Financial Entity").click }
      action(:my_financial_entities) { |b| b.button(value: "My Financial Entities").click }
    end

  end

end