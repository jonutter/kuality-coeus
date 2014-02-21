Feature: Basic Award Validations

  As an Award Modifier, I want to know when an Award document contains errors and omissions,
  so that I can correct them.

  Background:
    Given Users exist with the following roles: Proposal Creator, Award Modifier
    And   a User exists with the roles: OSP Administrator, Proposal Submission in the 000001 unit

  Scenario: Add a Payment & Invoice Req before adding a PI
    Given the Award Modifier creates an Award
    When  I start adding a Payment & Invoice item to the Award
    Then  a warning appears saying tracking details won't be added until there's a PI
  @test
  Scenario: Attempt to create a KC Award document with a missing required field
    Given I log in with the Award Modifier user
    When  I create an Award with a missing required field
    Then  an error should appear indicating the field is required

  Scenario: Enter an account ID that contains non-alphanumeric characters
    Given the Award Modifier creates an Award
    When  an Account ID with special characters is added to the Award details
    Then  an error should say the Account ID may only contain letters or numbers

  Scenario: Enter a title containing invalid characters
    Given the Award Modifier creates an Award
    When  the Award's title is updated to include invalid characters
    Then  an error should say the Award's title contains invalid characters

  Scenario: Enter a title containing more than 200 characters
    Given the Award Modifier creates an Award
    When  the Award's title is made more than 200 characters long
    Then  an error should say the Award's title can't be longer than 200 characters

  Scenario: Attempt to link an IP that has not been approved
    Given the Proposal Creator submits a new Proposal into routing
    And   the OSP Administrator submits the Proposal to its sponsor
    When  the Award Modifier adds the Institutional Proposal to the Award
    Then  an error should appear that says the IP can not be added because it's not fully approved

  Scenario: Organization added twice as an Approved Subaward
    Given the Award Modifier creates an Award
    And   adds a subaward to the Award
    And   adds the same organization as a subaward again to the Award
    When  data validation is turned on for the Award
    Then  an error should appear that says the duplicate organizations is shown

  Scenario: Terms are not entered in the Award
    Given the Award Modifier creates an Award
    When  data validation is turned on for the Award
    Then  an error should appear that says the terms are missing
