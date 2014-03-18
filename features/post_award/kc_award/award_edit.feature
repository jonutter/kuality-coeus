Feature: Editing Awards

  As an Award Modifier, I want to be able to make changes to Award documents,
  so that I can correct inaccuracies or enter additional data into optional fields

  Background:
    * a User exists with the role 'Award Modifier' in unit 'BL-BL'

  Scenario: Award Modifier adds a PI to an Award
    Given the Award Modifier creates an Award with BL-BL as the Lead Unit
    When  the Award Modifier adds a PI to the Award
    Then  The Award PI's Lead Unit is BL-BL

  Scenario: Award has no Principal Investigator added
    Given the Award Modifier creates an Award
    When  a Co-Investigator is added to the Award
    Then  an error should appear that says the Award has no PI
  @test
  Scenario: Add two Pricipal Investigators
    Given the Award Modifier creates an Award
    And   adds a PI to the Award
    When  another Principal Investigator is added to the Award
    Then  an error appears that says only one PI is allowed