Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

#=================
# Proposal Actions
#=================
  @test
  Scenario Outline: Proposal is successfully routed to PI for action
    Given users exist with the following roles: OSPApprover, Proposal Creator, Unassigned
    And   I log in with the Proposal Creator user
    And   initiate a proposal
    And   add the Unassigned user as a Principal Investigator to the key personnel proposal roles
    And   complete the required custom fields on the proposal
    And   submit the proposal
    When  the OSPApprover user approves the proposal
    And   I log in with the Unassigned user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario Outline: Proposal is successfully routed to OSP Approver for action
    Given users exist with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I log in with the OSPApprover user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario: Aggregator successfully submits a proposal into routing
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    When  I submit the proposal
    Then  the proposal status should be Approval Pending

  Scenario: Aggregator successfully blanket approves a routed proposal
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I submit a new development proposal into routing
    When  I blanket approve the proposal
    Then  the proposal status should be Approval Granted

  Scenario: Aggregator successfully recalls a routed proposal
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I submit a new development proposal into routing
    When  I recall the proposal
    Then  the proposal status should be Revisions Requested

  Scenario: Successful submission of a Private Profit proposal document into routing
    When  I complete a valid simple proposal for a 'Private Profit' organization
    And   submit the proposal
    Then  The proposal should immediately have a status of 'Approval Pending'
    And   The proposal route log's 'Actions Taken' should include 'COMPLETED'
    And   The proposal's 'Future Action Requests' should include 'PENDING APPROVE' for the principal investigator

#=================
# Notifications
#=================
  Scenario: Successful delivery of an FYI from a development proposal
    Given users exist with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    When  I send a notification to the OSPApprover user
    And   I log in with the OSPApprover user
    Then  I should receive an action list item with the requested action being: FYI
    And   I can acknowledge the requested action list item