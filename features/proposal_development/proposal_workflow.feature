Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Background: KC user is logged in as admin
    Given   I'm logged in with admin

  # Proposal Approval -- User types assigned to routing will take this action against routed proposals
  Scenario: A PI receives a routed proposal in their action list and approves it
    And  I have users with the system roles of 'OSPApprover', 'Proposal Creator', and 'Unassigned'
    And  I log in with the Proposal Creator user
    And  I initiate a proposal
    And  I add the Unassigned user as a Principal Investigator to the key personnel proposal roles
    And  I complete the proposal
    And  I submit the proposal
    When the OSPApprover user approves the proposal
    And  I log in with the Unassigned user
    Then the Unassigned user can approve the proposal document

  Scenario: An Aggregator (e.g. Proposal Creator) receives their routed proposal back in their action list and approves it
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

  Scenario Outline: An OSP Approver takes an action against a routed proposal and the proposal's status is changed
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

  Scenario: An Aggregator can submit a proposal once it has been completed
    Given I have a user with the system role: 'Proposal Creator'
    And   I initiate a proposal
    And   I complete the proposal
    Then  I can submit the proposal document
    And   the proposal status should be Approval Pending

  Scenario An OSP Approver takes the 'Submit to sponsor' action against a routed proposal and it's status changes
  Scenario An OSP Approver takes the 'Submit to sponsor' action against a routed proposal and an institutional proposal is created

  # Proposal Recalls -- A Proposal development document is taken out of routing for revisions/cancellation.
  Scenario: A proposal Aggregator recalls a proposal for cancellation
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I recall and cancel the proposal
    Then  the proposal status should be 'Document Error Occurred'

  Scenario: A proposal Aggregator recalls a proposal to make revisions
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I recall the proposal for revisions
    Then  the proposal is in the Proposal Creator user's action list
    And   when the proposal is opened the status should be 'Revisions Requested'

  # Notifications -- Notifications are sent are FYIs to select users.
  Scenario: Notifications sent from proposal documents appear as FYIs for OSP Approver users
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    When  I send a notification to the following users: OSPApprover
    And   I log in with the OSPApprover user
    Then  the proposal is in the OSPApprover user's action list as an FYI
    And   the OSPApprover user can Acknowledge the requested action list item

#   Note: This will be a test to evaluate whether a user can
#   Scenario: An OSPApprover user can filter all of their FYIs and acknowledge them at once

  # Action List -- Routed proposals appear in select user's action lists with requested actions
  Scenario: An OSP Approver receives a routed proposal in their action list
    Given I have a user with the system role: 'OSPApprover'
    And   I initiate a proposal
    And   I complete the proposal
    When  I submit the proposal
    Then  the proposal is in the OSPApprover user's action list