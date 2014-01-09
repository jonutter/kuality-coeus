Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Background:
    * a User exists with the role: 'Proposal Creator'
  @test
  Scenario Outline: Proposal is successfully routed to PI for action
    Given Users exist with the following roles: OSPApprover, Unassigned
    And   I log in with the Proposal Creator user
    And   create a Proposal
    And   add the Unassigned user as a Principal Investigator to the key personnel proposal roles
    And   set valid credit splits for the Proposal
    And   complete the required custom fields on the Proposal
    And   submit the Proposal
    When  the OSPApprover user approves the Proposal
    And   I log in with the Unassigned user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario Outline: Proposal is successfully routed to OSP Approver for action
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

  Scenario: Aggregator successfully submits a proposal into routing
    Given I log in with the Proposal Creator user
    And   submit a new Proposal into routing
    Then  the Proposal status should be Approval Pending
  #FIXME!
  @fixme
  Scenario: Aggregator successfully blanket approves a routed proposal
    Given I log in with the Proposal Creator user
    And   I submit a new Proposal into routing
    When  I blanket approve the Proposal
    Then  the Proposal status should be Approval Granted

  Scenario: Aggregator successfully recalls a routed proposal
    Given I log in with the Proposal Creator user
    And   I submit a new Proposal into routing
    When  I recall the Proposal
    Then  the Proposal status should be Revisions Requested

  Scenario: Successful delivery of an FYI from a development proposal
    Given a User exists with the role: 'OSPApprover'
    And   I log in with the Proposal Creator user
    And   I create a Proposal
    When  I send a notification to the OSPApprover user
    And   I log in with the OSPApprover user
    Then  I should receive an action list item with the requested action being: FYI
    And   I can acknowledge the requested action list item
  #FIXME
  @fixme
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

  Scenario: Approve a proposal with future approval requests
    Given a User exists with the role: 'OSPApprover'
    And   I log in with the Proposal Creator user
    And   I submit a new Proposal into routing
    And   I log in with the OSPApprover user
    And   I approve the Proposal with future approval requests
    And   the principal investigator approves the Proposal
    When  I log in again with the OSPApprover user
    Then  I should only have the option to approve the proposal
  #@test
  Scenario: Approve a proposal without future approval requests
    Given a User exists with the role: 'OSPApprover'
    And   I log in with the Proposal Creator user
    And   I submit a new Proposal into routing
    And   I log in with the OSPApprover user
    And   I approve the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    When  I log in again with the OSPApprover user
    Then  I should only have the option to submit the proposal to its sponsor
  #@test
  Scenario: Submit a proposal to its sponsor
    Given a User exists with the role: 'OSPApprover'
    And   I log in with the Proposal Creator user
    And   I submit a new Proposal into routing
    And   I log in with the OSPApprover user
    And   I approve the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    And   I log in again with the OSPApprover user
    When  I submit the Proposal to its sponsor
    Then  the Proposal status should be Approved and Submitted