Feature: Key Personnel Validations

  As a researcher I want to know if there are problems
  with my proposal's key personnel so that I can fix them
  before I submit the proposal

  Background: KC user is logged in as admin

  Scenario Outline: Unable to add Credit Split percentages above 100 or less than 0
    And     I initiate a proposal
    When    I add a Principal Investigator with a <Type> credit split of <Value>
    Then    a key personnel error should say the credit split is not a valid percentage

    Examples:
    | Type           | Value  |
    | Responsibility | 100.01 |
    | Financial      | 1000   |
    | Recognition    | -0.01  |

  Scenario: Attempt to add key personnel without a proposal role specified
    And     I initiate a proposal
    When    I add a key person without a key person role
    Then    a key personnel error should say a key person role is required

  Scenario: Attempt to add a a co-investigator without a unit
    And     I initiate a proposal
    When    I add a co-investigator without a unit
    Then    a key personnel error should say the co-investigator requires at least one unit

  Scenario: Attempt to add multiple principle investigators
    And     I initiate a proposal
    When    I try to add two Principal Investigators
    Then    a key personnel error should say only one PI is allowed

  Scenario: Attempt to add a key person with an invalid unit
    And     I initiate a proposal
    When    I add a key person with an invalid unit type
    Then    a key personnel error should say to select a valid unit

  Scenario: Attempt to add the same user as a PI and Co-Investigator
    And     I have a user with the system role: 'Unassigned'
    And     I initiate a proposal
    And     the proposal has no principal investigator
    When    I add the Unassigned user as a Principal Investigator to the key personnel proposal roles
    And     I add the Unassigned user as a Co-Investigator to the key personnel proposal roles
    Then    there should be an error that says the Unassigned user already holds investigator role