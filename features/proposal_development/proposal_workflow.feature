Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Background: KC user is logged in as admin
    Given   I'm logged in with admin

  # Proposal Actions -- User types assigned to routing will can approve, disapprove, reject, and recall development proposals
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

  Scenario: An Aggregator receives their routed proposal back in their action list and approves it
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

  Scenario Outline: An OSP Approver takes an action against a routed development proposal its status is changed
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
  @test
  Scenario: An Aggregator submits a proposal and the status is changed
    Given I have a user with the system role: 'Proposal Creator'
    And   I initiate a proposal
    And   I complete the proposal
    Then  I can submit the proposal document
    And   the proposal status should be Approval Pending

#Scenario: A proposal Aggregator takes the 'blanket approve' action against a routed proposal and its status changes

  Scenario An OSP Approver takes the 'Submit to sponsor' action against a routed proposal and it's status changes
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I log in with the OSPApprover user
    And   I submit the routed proposal to a sponsor
    Then  the proposal status should be Approval Pending - Submitted

#Scenario: An OSP Approver takes the 'Submit to sponsor' action against a routed proposal and an institutional proposal is created

  Scenario: A proposal Aggregator recalls a proposal for cancellation and the status is changed
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I recall and cancel the proposal
    Then  the proposal status should be 'Document Error Occurred'

  Scenario: A development proposal Aggregator recalls a proposal to make revisions and the status is changed
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I recall the proposal for revisions
    Then  the proposal is in the Proposal Creator user's action list
    And   when the proposal is opened the status should be 'Revisions Requested'

  Scenario: A development proposal

  # Notifications -- Notifications are sent are FYIs to select users.
  Scenario: A notification is sent from a development proposal and it appears as an FYI for the OSP Approver user
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    When  I send a notification to the following users: OSPApprover
    And   I log in with the OSPApprover user
    Then  the proposal is in the OSPApprover user's action list as an FYI
    And   the OSPApprover user can Acknowledge the requested action list item

#Scenario: An OSPApprover user can filter all of their FYIs and acknowledge them at once

  # Action List -- Routed proposals appear in select user's action lists with requested actions
  Scenario: An OSP Approver receives a newly submitted proposal in their action list
    Given I have a user with the system role: 'OSPApprover'
    And   I initiate a proposal
    And   I complete the proposal
    When  I submit the proposal
    Then  the proposal is in the OSPApprover user's action list