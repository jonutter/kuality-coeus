Feature: Key Personnel Validations

  As a researcher I want to know if there are problems
  with my proposal's key personnel so that I can fix them
  before I submit the proposal

  Background: KC user is logged in as admin
    Given I am logged in as admin
    And   I begin a proposal

  Scenario Outline: Unable to add Credit Split percentages above 100 or less than 0
    When  I add a Key Person with a <Type> credit split of <Value>
    Then  I should see an error that the credit split is not a valid percentage

    Examples:
    | Type           | Value  |
    | Responsibility | 100.01 |
    | Financial      | 1000   |
    | Recognition    | -0.01  |
  @test
  Scenario: Trying to add two PIs to a Proposal
    When  I try to add two Principal Investigators
    Then  I should see an error that only one PI is allowed