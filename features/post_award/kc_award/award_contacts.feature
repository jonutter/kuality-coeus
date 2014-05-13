Feature: Award Contacts

  As an Award Modifier, I want to be able to make changes to Award Personnel,
  so that I can...

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

  Scenario: Add two Principal Investigators
    Given the Award Modifier creates an Award
    And   adds a PI to the Award
    When  another Principal Investigator is added to the Award
    Then  an error should appear that says only one PI is allowed in the Contacts

  Scenario: Same Contact with two roles
    Given the Award Modifier creates an Award
    And   adds a PI to the Award
    When  the Award's PI is added again with a different role
    Then  the Award should throw an error saying they are already in the Award Personnel

  Scenario: Adding a non-employee without a Unit
    Given the Award Modifier creates an Award
    And   adds a non-employee as a Principal Investigator to the Award
    When  the Award's Principal Investigator has no units
    Then  the Award should throw an error saying the Award's PI requires at least one unit
