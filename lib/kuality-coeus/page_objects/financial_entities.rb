class FinancialEntities < BasePage

  global_buttons

  class << self

    def financial_entities_tabs
      action(:reporter) { |b| b.frm.button(value: "Reporter").click }
      action(:new_financial_entity) { |b| b.frm.button(value: "New Financial Entity").click }
      action(:my_financial_entities) { |b| b.frm.button(value: "My Financial Entities").click }
    end

  end

end