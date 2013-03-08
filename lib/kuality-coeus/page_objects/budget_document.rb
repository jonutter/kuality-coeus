class BudgetDocument < BasePage

  budget_header_elements
  global_buttons
  document_header_elements

  class << self

    def return_button
      action(:return_to_proposal) { |b| b.frm.button(alt: "return to proposal") }
    end

  end

end