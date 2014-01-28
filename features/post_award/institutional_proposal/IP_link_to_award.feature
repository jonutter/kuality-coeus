Feature: Linking an Institutional Proposal to a KC Award

  To be determined.

  Background: Establish test users
    * Users exist with the following roles: Award Modifier

    Scenario: Linking a Funding Proposal to an Award
      Given a Funding Proposal has been generated out of the Development Proposal workflow
      When  the Award Modifier user links the Funding Proposal to a new Award
      Then  the status of the Funding Proposal should change to Funded
    #Failing
      #Write the expected outcome step.
  @test
    Scenario: Edit a 'Funded' Institutional Proposal
      Given the Award Modifier adds an Institutional Proposal to an Award
      #When  I attempt to edit the Institutional Proposal
      #Then  a new Institutional Proposal should be generated