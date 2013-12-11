Feature: Basic Award Validations

  As an Award Modifier, I want to know when an Award document contains errors and omissions,
  so that I can correct them.

  Background:
    Given Users exist with the following roles: Proposal Creator, Award Modifier
    And   a User exists with the roles: OSP Administrator, Institutional Proposal Maintainer in the 000001 unit

  Scenario: Add a Payment & Invoice Req before adding a PI
    Given I initiate an Award
    When  I start adding a Payment & Invoice item to the Award
    Then  a warning appears saying tracking details won't be added until there's a PI

  Scenario: Attempt to initiate a KC Award document with a missing required field
    When  I initiate an Award with a missing required field
    Then  an error should appear that says the field is required
  @test
  Scenario: Attempt to link an IP that has not been approved
    Given I log in with the Proposal Creator user
    And   I submit a new Proposal into routing
    And   the OSP Administrator submits the Proposal to its sponsor
    When  the Award Modifier tries to fund an Award with the new Institutional Proposal
    Then  an error should say the IP can not be added because it was not been properly approved
