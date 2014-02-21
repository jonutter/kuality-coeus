class BudgetVersions < ProposalDevelopmentDocument

  budget_versions_elements

  element(:name_of_copy) { |b| b.frm.text_field(name: /budgetVersionOverview.documentDescription/) }

  action(:final) { |budget, p| p.budgetline(budget).checkbox(title: 'Final?') }

  action(:residual_funds) { |budget, p| p.budget_table(budget)[0][1].text }


end