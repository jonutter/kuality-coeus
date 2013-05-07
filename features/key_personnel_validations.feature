Feature: Key Personnel Validations

  As a researcher I want to know if there are problems
  with my proposal's key personnel so that I can fix them
  before I submit the proposal

  Background: KC user is logged in as admin
    Given   I'm logged in with admin
    And     I initiate a proposal

  Scenario Outline: Unable to add Credit Split percentages above 100 or less than 0
    When    I add a Principal Investigator with a <Type> credit split of <Value>
    Then    I should see an error that the credit split is not a valid percentage

    Examples:
    | Type           | Value  |
    | Responsibility | 100.01 |
    | Financial      | 1000   |
    | Recognition    | -0.01  |

  Scenario: Attempt to add key personnel without a proposal role specified
    When    I add a key person without a key person role
    Then    I should see an error that says proposal role is required

  Scenario: Trying to add a a co-investigator without a unit
    When    I add a co-investigator without a unit
    Then    I should see a key personnel error that says at least one unit is required

  Scenario: Attempt to add multiple principle investigators
    When    I try to add two Principal Investigators
    Then    I should see an error that says only one pi role is allowed

  Scenario: Attempt to add person with invalid unit
    When    I add a key person with an invalid unit type
    Then    I should see an error that says please select a valid unit