Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Background:
    * Users exist with the following roles: Proposal Creator, OSPApprover

  Scenario: Approval Requests for a Proposal are sent
    When the Proposal Creator submits a new Proposal into routing
    Then the Proposal status should be Approval Pending

  Scenario: Copying a submitted Proposal
    When the Proposal Creator submits a new Proposal into routing
    Then it is still possible to copy the Proposal

   Scenario: Approval Request is sent to the Proposal's PI
    Given the Proposal Creator submits a new Proposal into routing
    When  the OSPApprover user approves the Proposal
    Then  the principal investigator can access the Proposal from their action list
    And   the approval buttons appear on the Proposal Summary and Proposal Action pages

   Scenario: Approval Requests are sent to OSP representatives
    When  the Proposal Creator submits a new Proposal into routing
    Then  the OSPApprover can access the Proposal from their action list
    And   the approval buttons appear on the Proposal Summary and Proposal Action pages

   Scenario: Proposal is recalled
    Given the Proposal Creator submits a new Proposal into routing
    When  I recall the Proposal
    Then  the Proposal status should be Revisions Requested

   Scenario: An OSP Admin overrides a budget's cost sharing amount
    Given the Budget Column's 'Cost Sharing Amount' has a lookup for 'Proposal Cost Share' that returns 'Amount'
    And   a User exists with the role: 'OSP Administrator'
    And   the Proposal Creator creates a Proposal
    And   adds a principal investigator to the Proposal
    And   sets valid credit splits for the Proposal
    And   the Proposal Creator user creates a Budget Version with cost sharing for the Proposal
    And   finalizes the Budget Version
    And   marks the Budget Version complete
    And   completes the required custom fields on the Proposal
    When  the Proposal is submitted
    Then  the OSP Administrator can override the cost sharing amount

   Scenario: An OSP representative grants the final approval of a Proposal's workflow
    Given the Proposal Creator submits a new Proposal into routing
    And   the OSPApprover approves the Proposal with future approval requests
    And   the principal investigator approves the Proposal
    When  the OSPApprover approves the Proposal again
    Then  the Proposal status should be Approval Granted

   Scenario: An OSP representative approves a proposal and requests future approval requests
    Given the Proposal Creator submits a new Proposal into routing
    When  the OSPApprover approves the Proposal with future approval requests
    And   the principal investigator approves the Proposal
    And   I log in again with the OSPApprover user
    Then  I should see the option to approve the Proposal

   Scenario: An OSP representative approves a proposal and declines future approval requests
    Given the Proposal Creator submits a new Proposal into routing
    And   the OSPApprover approves the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    When  I log in again with the OSPApprover user
    Then  I should not see the option to approve the Proposal

   Scenario: Approval has been granted so an OSP Admin submits the Proposal to its sponsor
    Given a User exists with the roles: OSP Administrator, Proposal Submission in the 000001 unit
    And   the Proposal Creator submits a new Proposal into routing
    And   the OSPApprover approves the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    When  the OSP Administrator submits the Proposal to its sponsor
    Then  the Proposal status should be Approved and Submitted