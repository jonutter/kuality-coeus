Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Background: KC user is logged in as admin
    Given   I'm logged in with admin

  Scenario: An OSP Approver can acknowledge an FYI
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    When  I send a notification to the following users: OSPApprover
#    And   I log in with the OSPApprover user
#    Then  the proposal is in the OSPApprover user's action list
#    And   the OSPApprover user can acknowledge the requested action list item

  Scenario: Users with the OSP Approver role get submitted proposals routed to their action list
    Given I have a user with the system role: 'OSPApprover'
    And   I initiate a proposal
    And   I complete the proposal
    When  I submit the proposal
    Then  the proposal is in the OSPApprover user's action list

  Scenario: A proposal Aggregator user can approve a proposal that has been routed
    And     I have users with the following roles: OSPApprover, Proposal Creator, Unassigned
    And     I log in with the Proposal Creator user
    And     I initiate a proposal
    And     I add the Unassigned user as a principal investigator to the key personnel proposal roles
    And     I complete the proposal
    And     I submit the proposal
    When    the OSPApprover user approves the proposal
    And     I log in with the Unassigned user
    And     the Unassigned user approves the proposal
    Then    the Proposal Creator user can approve the proposal document

  Scenario Outline: An OSP Approver can reject a proposal that has been routed
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I log in with the OSPApprover user
    Then  the OSPApprover user can <Action> the proposal document
    And   the status of the proposal document should change to <Status>

  Examples:
    | Action       | Status              |
    | Approve      | Approval Pending    |
    | Disapprove   | Disapproved         |
    | Reject       | Revisions Requested |

  Scenario: A proposal document's Aggregator can submit a proposal once completed
    Given I have a user with the system role: 'Proposal Creator'
    And   I initiate a proposal
    And   I complete the proposal
    Then  I can submit the proposal document
    And   the proposal status should be Approval Pending

  Scenario: User with Proposal Creator role can recall their proposals for cancellation
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I recall and cancel the proposal
    Then  the proposal status should be 'Document Error Occurred'

  Scenario: Users with the Proposal Creator role can recall their proposals for revisions
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I recall the proposal for revisions
    Then  the proposal is in the Proposal Creator user's action list
    And   when the proposal is opened the status should be 'Revisions Requested'