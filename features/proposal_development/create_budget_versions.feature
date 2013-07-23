Feature: Creating/Editing Budget Versions in Proposal Documents

  As a researcher I want to be able to create budgets in my proposals
  so that I can calculate how much the proposal should be for.

  Background: Create a Budget Version for a 5-year proposal
    Given I'm logged in with admin
    And   I initiate a 5-year project proposal
    And   create a budget version for the proposal

  Scenario: System warns about budget periods when proposal dates change
    When  I push the proposal's project start date ahead a year
    Then  opening the Budget Version will display a warning about the date change
    And   correcting the Budget Version date will remove the warning

  Scenario: Copied budget periods have expected values
    Given I enter dollar amounts for all the budget periods
    When  I copy the budget version (all periods)
    Then  the copied budget's values are all as expected

  Scenario: "Default Periods" returns budget periods to a zeroed state
    Given I delete one of the budget periods
    And   enter dollar amounts for all the budget periods
    And   change the date range for one of the periods
    When  I select the default periods for the budget version
    Then  all budget periods get recreated, zeroed, and given default date ranges

  Scenario: Only one budget version can be 'final'
    Given I finalize the budget version
    When  I copy the budget version (all periods)
    Then  I see an error that only one version can be final