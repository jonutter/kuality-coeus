Feature: Creating Budget Versions in Proposal Documents

  As a researcher I want to be able to create budgets in my proposals
  so that I can calculate how much the proposal should be for.

  Background: Logged in to system with Create Proposal permissions
    Given   I'm logged in with admin

  Scenario: System warns about budget periods when proposal dates change
    Given I initiate a 5-year project proposal
    And   I create a budget version for the proposal
    When  I push the proposal's project start date ahead a year
    Then  opening the Budget Version will display a warning about the date change
    And   correcting the Budget Version date will remove the warning

  Scenario: Copied budget periods have expected values
    Given I initiate a 3-year project proposal
    And   I create a budget version for the proposal
    And   I enter values for all the budget periods
    When  I copy the budget version (all periods)
    Then  the copied budget's values are all as expected