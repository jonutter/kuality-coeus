Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Background:
    * Users exist with the following roles: Proposal Creator, Unassigned

  Scenario: Approval Requests for a Proposal are sent
    Given the Proposal Creator submits a new Proposal into routing
    Then  the Proposal status should be Approval Pending

  Scenario Outline: Approval Request is sent to the Proposal's PI
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator submits a new Proposal into routing
    And   the OSPApprover user approves the Proposal
    When  I log in with the Unassigned user
    And   I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario Outline: Approval Requests are sent to OSP representatives
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator submits a new Proposal into routing
    When  I log in with the OSPApprover user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario: Proposal is recalled
    Given the Proposal Creator submits a new Proposal into routing
    When  I recall the Proposal
    Then  the Proposal status should be Revisions Requested

  Scenario: An FYI is sent to an OSP representative
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator creates a Proposal
    When  I send a notification to the OSPApprover user
    And   I log in with the OSPApprover user
    Then  I should receive an action list item with the requested action being: FYI
    And   I can acknowledge the requested action list item
  #FIXME
  #@fixme
  Scenario: An OSP Admin overrides a budget's cost sharing amount
    Given the Budget Column's 'Cost Sharing Amount' has a lookup for 'Proposal Cost Share' that returns 'Amount'
    And   a User exists with the role: 'OSP Administrator'
    And   the Proposal Creator creates a Proposal
    And   add a principal investigator to the Proposal
    And   set valid credit splits for the Proposal
    And   create a Budget Version with cost sharing for the Proposal
    And   finalize the Budget Version
    And   mark the Budget Version complete
    And   complete the required custom fields on the Proposal
    And   submit the Proposal
    When  I log in with the OSP Administrator user
    Then  I can override the cost sharing amount

  Scenario: An OSP representative grants the final approval of a Proposal's workflow
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator submits a new Proposal into routing
    And   the OSPApprover approves the Proposal with future approval requests
    And   the principal investigator approves the Proposal
    When  the OSPApprover approves the Proposal again
    Then  the Proposal status should be Approval Granted

  Scenario: An OSP representative approves a proposal and requests future approval requests
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator submits a new Proposal into routing
    When  the OSPApprover approves the Proposal with future approval requests
    And   the principal investigator approves the Proposal
    And   I log in again with the OSPApprover user
    Then  I should see the option to approve the Proposal

  Scenario: An OSP representative approves a proposal and declines future approval requests
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator submits a new Proposal into routing
    And   the OSPApprover approves the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    When  I log in again with the OSPApprover user
    Then  I should not see the option to approve the Proposal
  @test
  Scenario: Approval has been granted so an OSP Admin submits the Proposal to its sponsor
    Given a User exists with the roles: OSP Administrator, Proposal Submission in the 000001 unit
    And   Users exist with the following roles: OSPApprover, Unassigned
    And   the Proposal Creator submits a new Proposal into routing
    And   the OSPApprover approves the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    When  the OSP Administrator submits the Proposal to its sponsor
    Then  the Proposal status should be Approved and Submitted