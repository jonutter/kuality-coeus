Feature: Linking an Institutional Proposal to a KC Award

  To be determined.

  Background: Establish test users
    * Users exist with the following roles: Proposal Creator, Award Modifier, OSPApprover
    * a User exists with the roles: OSP Administrator, Proposal Submission, Institutional Proposal Maintainer in the 000001 unit
    @test
    Scenario: Linking a Funding Proposal to an Award
      Given the Proposal Creator submits a new Proposal into routing
      And   the OSPApprover approves the Proposal without future approval requests
      And   the principal investigator approves the Proposal
      And   the OSP Administrator submits the Proposal to its sponsor
      When  the Award Modifier user links the Funding Proposal to a new Award
      Then  the status of the Funding Proposal should change to Funded

    Scenario: Edit a 'Funded' Institutional Proposal
      Given I add an Institutional Proposal to an Award
      When  I attempt to edit the Institutional Proposal
      Then  a new Institutional Proposal should be generated