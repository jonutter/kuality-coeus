Feature: Linking an Institutional Proposal to a KC Award

  To be determined.

  Background: Establish test users
    Given Users exist with the following roles: Proposal Creator, Award Modifier
    And   a User exists with the roles: OSP Administrator, Institutional Proposal Maintainer in the 000001 unit
    @test
    Scenario: KC-TS-104 Unlock an Institutional Proposal
      Given I create a Funding Proposal
      When  I log in with the Award Modifier user
      And   I link the Funding Proposal to an Award
      Then  the status of the Funding Proposal should change to Funded

    Scenario: Edit a 'Funded' Institutional Proposal
      Given I add an Institutional Proposal to an Award
      When  I attempt to edit the Institutional Proposal
      Then  a new Institutional Proposal should be generated
