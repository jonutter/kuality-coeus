Feature: Editing Awards

  As an Award Modifier, I want to be able to make changes to Award documents,
  so that I can correct inaccuracies or enter additional data into optional fields

  Background:
    * a User exists with the role 'Award Modifier' in unit 'BL-BL'

  Scenario: Award Modifier adds a PI to an Award
    Given the Award Modifier creates an Award with BL-BL as the Lead Unit
    When  I add a PI to the Award
    Then  The Award PI's Lead Unit is BL-BL

  Scenario: Award has no Principal Investigator added
    Given the Award Modifier creates an Award
    When  a Co-Investigator is added to the Award
    Then  an error should appear that says the Award has no PI