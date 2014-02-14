Feature: Linking an Institutional Proposal to a KC Award

  To be determined.

  Background: Establish test users
    * Users exist with the following roles: Award Modifier, Proposal Creator, OSPApprover
    * a User exists with the roles: OSP Administrator, Proposal Submission in the 000001 unit

    Scenario: Linking a Funding Proposal to an Award
      Given a Funding Proposal has been generated out of the Development Proposal workflow
      When  the Award Modifier user links the Funding Proposal to a new Award
      Then  the status of the Funding Proposal should change to Funded

    #Failing
      #Write the expected outcome step.
    Scenario: Edit a 'Funded' Institutional Proposal
      Given the Award Modifier adds an Institutional Proposal to an Award
      When  I edit the Institutional Proposal
      #Then  a new Institutional Proposal should be generated
    @test
    Scenario: KC-TS-1181 Funding Proposal Cost Share Amounts appear in Awards
      Given the Proposal Creator creates a Proposal
      And   creates a Budget Version with cost sharing for the Proposal
      And   adds another item to the budget period's cost sharing distribution list
      And   adjusts the budget period's cost sharing amount so all funds are allocated
      And   finalizes the Budget Version
      And   marks the Budget Version complete
      And   adds a principal investigator to the Proposal
      And   sets valid credit splits for the Proposal
      And   completes the required custom fields on the Proposal
      And   the Proposal Creator submits the Proposal into routing
      And   the OSPApprover approves the Proposal without future approval requests
      And   the principal investigator approves the Proposal
      And   the OSP Administrator submits the Proposal to its sponsor
      And   the Award Modifier creates an Award
      When  the Award Modifier user links the Funding Proposal to a new Award
      Then  the Award inherits the Cost Sharing data from the Funding Proposal