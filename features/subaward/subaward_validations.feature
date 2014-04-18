Feature: Subaward Validations

  TBD

  Scenario: Duplicate Funding Sources
    Given Users exist with the following roles: Modify Subaward, Award Modifier
    And   the Award Modifier creates an Award
    And   the Modify Subaward user creates a Subaward
    And   adds the Award as a Funding Source to the Subaward