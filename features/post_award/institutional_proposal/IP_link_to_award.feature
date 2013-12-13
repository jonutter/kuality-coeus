Feature: Linking an Institutional Proposal to a KC Award

  To be determined.

  Background: Establish test users
    Given Users exist with the following roles: Proposal Creator, Award Modifier
    And   a User exists with the roles: OSP Administrator, Institutional Proposal Maintainer in the 000001 unit

    Scenario: KC-TS-104 Unlock an Institutional Proposal
      Given I initiate an insitutional proposal
      When  I