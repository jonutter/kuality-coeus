class AwardBudgetVersions < KCAwards

  budget_versions_elements

  alias_method :new, :add

end