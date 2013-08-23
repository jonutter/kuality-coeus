Feature: Key Personnel Validations

  As a researcher I want to know if there are problems
  with my proposal's key personnel so that I can fix them
  before I submit the proposal

  Background: The admin user initiates a proposal
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal

  Scenario Outline: I should see an error when I add Credit Split percentages above 100 or less than 0
    When  I add a Principal Investigator with a <Type> credit split of <Value>
    Then  a key personnel error should say the credit split is not a valid percentage

    Examples:
    | Type           | Value  |
    | Responsibility | 100.01 |
    | Financial      | 1000   |
    | Recognition    | -0.01  |

  Scenario: I should see an error when I add a key person without a specified proposal role
    When  I add a key person without a key person role
    Then  a key personnel error should say a key person role is required

  Scenario: Error when adding a co-investigator without a unit
    When  I add a co-investigator without a unit
    Then  a key personnel error should appear, saying the co-investigator requires at least one unit

  Scenario: Error when adding multiple principle investigators
    When  I try to add two Principal Investigators
    Then  a key personnel error should say only one PI is allowed

  Scenario: Error when adding a key person with an invalid unit
    When  I add a key person with an invalid unit type
    Then  a key personnel error should say to select a valid unit

  Scenario: Error when adding the same user as a PI and Co-Investigator
    Given a user exists with the system role: 'Unassigned'
    When  I add the Unassigned user as a Principal Investigator to the key personnel proposal roles
    And   I add the Unassigned user as a Co-Investigator to the key personnel proposal roles
    Then  there should be an error that says the Unassigned user already holds investigator role