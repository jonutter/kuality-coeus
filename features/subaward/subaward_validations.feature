Feature: Subaward Validations

  TBD

  Background:
    * Users exist with the following roles: Modify Subaward, Award Modifier

    # Unable to add an Award as a funding source to a Subaward
    # see: https://jira.kuali.org/browse/KRAFDBCK-7390
  @broken
  Scenario: Duplicate Funding Sources
    Given the Award Modifier creates an Award
    And   the Modify Subaward user creates a Subaward
    And   adds the Award as a Funding Source to the Subaward

  Scenario: Invoiced amount exceeds Obligated amount
    Given the Modify Subaward user creates a Subaward
    And   adds a change to the Subaward amounts
    When  the Modify Subaward user adds an invoice to the Subaward with a released amount larger than the obligated amount
    Then  an error should appear that says the invoiced exceeds the obligated amount
  @test
  Scenario: Adding Contact with multiple roles
    Given the Modify Subaward user creates a Subaward
    And   adds a contact to the Subaward
    When  the Modify Subaward user adds the same contact to the Subaward, with a different role
    Then  there are no errors on the page
    When  the Modify Subaward user adds the same contact to the Subaward, with the same role
    Then  an error should appear on the Subaward saying the person is already added to the contacts