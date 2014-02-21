Feature: Editing Awards

  As an Award Modifier, I want to be able to make changes to Award documents,
  so that I can correct inaccuracies or enter additional data into optional fields

  Scenario: Award Modifier adds a PI to an Award
    Given a User exists with the role 'Award Modifier' in unit 'BL-BL'
    And   I log in with that User
    And   I create an Award with BL-BL as the Lead Unit
    When  I add a PI to the Award
    Then  The Award PI's Lead Unit is BL-BL