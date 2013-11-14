Feature: Basic Award Validations

  As an Award Modifier, I want to know when an Award document contains errors and omissions,
  so that I can correct them.

  Background:
    Given a User exists with the system role: 'Award Modifier'
    And   I log in with that User

  Scenario: Add a Payment & Invoice Req before adding a PI
    Given I initiate an Award
    When  I start adding a Payment & Invoice item to the Award
    Then  a warning appears saying tracking details won't be added until there's a PI

  Scenario: Attempt to initiate a KC Award document with a missing required field
    When  I initiate an Award with a missing required field
    Then  an error should appear that says the field is required