Feature: Creating/Editing Budget Versions in Proposal Documents

  As a researcher I want to be able to create budgets in my proposals
  so that I can calculate how much the proposal should be for.

  Background: Create a Budget Version for a 5-year proposal
    Given a User exists with the role: 'Proposal Creator'
    * the Proposal Creator creates a 5-year project Proposal
    * creates a Budget Version for the Proposal

  Scenario: System warns about budget periods when proposal dates change
    When  I push the Proposal's project start date ahead 1 year
    Then  opening the Budget Version will display a warning about the date change
    And   correcting the Budget Version date will remove the warning

  Scenario: Copied budget periods have expected values
    Given I enter dollar amounts for all the budget periods
    When  I copy the Budget Version (all periods)
    Then  the copied budget's values are all as expected

  Scenario: "Default Periods" returns budget periods to a zeroed state
    Given I delete one of the budget periods
    And   enter dollar amounts for all the budget periods
    And   change the date range for one of the periods
    When  I select the default periods for the Budget Version
    Then  all budget periods get recreated, zeroed, and given default date ranges

  Scenario: Only one budget version can be 'final'
    Given I finalize the Budget Version
    When  I copy the Budget Version (all periods)
    Then  an error should appear that says only one version can be final

  Scenario: Complete Budgets are read-only
    Given the Proposal Creator finalizes the Budget Version
    When  the Proposal Creator marks the Budget Version complete
    Then  the Budget Version is no longer editable

  Scenario: Adding years to the Proposal
    Given the Proposal Creator pushes the end date 2 more years
    When  the Proposal Creator selects the default periods for the Budget Version
    Then  the Budget Version should have two more budget periods