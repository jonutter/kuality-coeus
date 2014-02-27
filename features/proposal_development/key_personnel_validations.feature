Feature: Proposal Key Personnel Validations

  As a researcher I want to know if there are problems
  with my Proposal's key personnel so that I can fix them
  before I submit the Proposal

  Background: The admin user creates a proposal
    * a User exists with the role: 'Proposal Creator'
    * the Proposal Creator creates a Proposal

  Scenario Outline: I should see an error when I add Credit Split percentages above 100 or less than 0
    When I add a Principal Investigator with a <Type> credit split of <Value>
    Then an error should appear that says the credit split is not a valid percentage

    Examples:
    | Type           | Value  |
    | Responsibility | 100.01 |
    | Financial      | 1000   |
    | Recognition    | -0.01  |

  Scenario: I should see an error when I add a key person without a specified proposal role
    When I add a key person without a key person role
    Then an error should appear that says a key person role is required

  Scenario: Error when adding a co-investigator without a unit
    When I add a co-investigator without a unit to the Proposal
    Then an error requiring at least one unit for the co-investigator is shown

  Scenario: Error when adding multiple principle investigators
    When I try to add two principal investigators
    Then an error should appear that says only one PI is allowed

  Scenario: Error when adding a key person with an invalid unit
    When I add a key person with an invalid unit type
    Then an error should appear that says to select a valid unit

  Scenario: Error when adding the same user as a PI and Co-Investigator
    When I add the same person to the Proposal as a PI and Co-Investigator
    Then an error is shown that indicates the user is already an investigator