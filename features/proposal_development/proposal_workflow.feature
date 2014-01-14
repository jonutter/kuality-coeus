Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Background:
    * a User exists with the role: 'Proposal Creator'

  Scenario: Approval Requests for a Proposal are sent
    Given I log in with the Proposal Creator user
    And   submit a new Proposal into routing
    Then  the Proposal status should be Approval Pending

  Scenario Outline: Approval Request is sent to the Proposal's PI
    Given Users exist with the following roles: OSPApprover, Unassigned
    And   I log in with the Proposal Creator user
    When  I submit a new Proposal into routing
    And   the OSPApprover user approves the Proposal
    And   I log in with the Unassigned user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario Outline: Approval Request is sent to OSP Approver
    Given a User exists with the role: 'OSPApprover'
    And   I log in with the Proposal Creator user
    And   submit a new Proposal into routing
    When  I log in with the OSPApprover user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario: Proposal is recalled
    Given I log in with the Proposal Creator user
    And   I submit a new Proposal into routing
    When  I recall the Proposal
    Then  the Proposal status should be Revisions Requested

  Scenario: FYI (Notification) is sent
    Given a User exists with the role: 'OSPApprover'
    And   I log in with the Proposal Creator user
    And   I create a Proposal
    When  I send a notification to the OSPApprover user
    And   I log in with the OSPApprover user
    Then  I should receive an action list item with the requested action being: FYI
    And   I can acknowledge the requested action list item
  #FIXME
  #@fixme
  Scenario: An OSP Admin overrides a budget's cost sharing amount
    Given the Budget Column's 'Cost Sharing Amount' has a lookup for 'Proposal Cost Share' that returns 'Amount'
    And   a User exists with the role: 'OSP Administrator'
    And   I log in with the Proposal Creator user
    And   create a Proposal
    And   add a principal investigator to the Proposal
    And   set valid credit splits for the Proposal
    And   create a Budget Version with cost sharing for the Proposal
    And   finalize the Budget Version
    And   mark the Budget Version complete
    And   complete the required custom fields on the Proposal
    And   submit the Proposal
    When  I log in with the OSP Administrator user
    Then  I can override the cost sharing amount
  @test
  Scenario: OSP personnel grants the final approval of a Proposal's workflow
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator submits a new Proposal into routing
    And   I log in with the OSPApprover user
    And   I approve the Proposal with future approval requests
    And   the principal investigator approves the Proposal
    When  I log in again with the OSPApprover user
    And   I approve the Proposal
    Then  the Proposal status should be Approval Granted

  Scenario: OSP personnel approves a proposal with future approval requests
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator submits a new Proposal into routing
    And   I log in with the OSPApprover user
    And   I approve the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    When  I log in again with the OSPApprover user
    Then  I should see the option to approve the Proposal
  #@test
  Scenario: OSP personnel approves a proposal without future approval requests
    Given a User exists with the role: 'OSPApprover'
    And   the Proposal Creator submits a new Proposal into routing
    And   I log in with the OSPApprover user
    And   I approve the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    When  I log in again with the OSPApprover user
    Then  I should only have the option to submit the proposal to its sponsor

  Scenario: Submit a proposal to its sponsor
    Given a User exists with the roles: OSP Administrator, Proposal Submission in the 000001 unit
    And   the Proposal Creator submits a new Proposal into routing
    And   log in as the User with the OSP Administrator role in 000001
    And   I approve the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    And   log in again as the User with the OSP Administration role in 000001
    When  I submit the Proposal to its sponsor
    Then  the Proposal status should be Approved and Submitted