Feature: Linking an Institutional Proposal to a KC Award

  To be determined.

  Background: Establish test users
    * Users exist with the following roles: Award Modifier, Proposal Creator, OSPApprover
    * a User exists with the roles: OSP Administrator, Proposal Submission, Institutional Proposal Maintainer in the 000001 unit

    Scenario: Linking a Funding Proposal to an Award
      Given 1 Approved Institutional Proposal exists
      When  the Award Modifier links the Funding Proposal to a new Award
      Then  the status of the Funding Proposal should change to Funded
      And   the Funding Proposal version should be '2'

    Scenario: Edit a 'Funded' Institutional Proposal
      Given the Award Modifier adds a new Institutional Proposal to a new Award
      When  the Institutional Proposal Maintainer edits the Institutional Proposal
      Then  the Funding Proposal version should be '3'

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
      And   submits the Proposal into routing
      And   the OSPApprover approves the Proposal without future approval requests
      And   the principal investigator approves the Proposal
      And   the OSP Administrator submits the Proposal to its sponsor
      And   the Award Modifier creates an Award
      When  the Funding Proposal is linked to a new Award
      Then  the Award inherits the Cost Sharing data from the Funding Proposal