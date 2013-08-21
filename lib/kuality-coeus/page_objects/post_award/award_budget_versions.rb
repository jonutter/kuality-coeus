class AwardBudgetVersions < KCAwards

  award_header_elements
  error_messages
  budget_versions_elements

  alias_method :new, :add

end