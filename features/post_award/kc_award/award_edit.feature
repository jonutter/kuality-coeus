Feature: Modifying Award Properties

  As an Award Modifier, I want to be able to make changes to Award documents,
  so that I can set them up properly
  @failing
  Scenario: Award Modifier adds a PI to an Award
    Given a User exists with the role 'Award Modifier' in unit 'BL-BL'
    And   I log in with that User
    And   I create an Award with BL-BL as the Lead Unit
    When  I add a PI to the Award
    Then  The Award PI's Lead Unit is BL-BL