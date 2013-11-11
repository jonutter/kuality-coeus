class AwardBudgetVersions < KCAwards

  award_header_elements
  budget_versions_elements

  alias_method :new, :add

end