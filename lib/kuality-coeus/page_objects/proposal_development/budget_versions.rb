class BudgetVersions < ProposalDevelopmentDocument

  proposal_header_elements

  element(:name) { |b| b.frm.text_field(name: "newBudgetVersionName") }
  action(:add) { |b| b.frm.button(name: "methodToCall.addBudgetVersion").click }

end