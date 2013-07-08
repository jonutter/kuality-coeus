Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Background: KC user is logged in as admin
    Given   I'm logged in with admin

#=================
# Proposal Actions -- User types assigned to routing can approve, disapprove, reject, and recall development proposals
#=================
  Scenario Outline: A PI who receives a routed proposal in their action list has the option to approve, disapprove, or reject it
    Given I have users with the following roles: OSPApprover, Proposal Creator, Unassigned
    And   I log in with the Proposal Creator user
    And   I initiate a development proposal
    And   I add the Unassigned user as a Principal Investigator to the key personnel proposal roles
    And   I complete the required fields on the proposal
    And   I submit the proposal
    When  the OSPApprover user approves the proposal
    And   I log in with the Unassigned user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario Outline: An OSP Approver who receives a routed proposal in their action list has the option to approve, disapprove, or reject it
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a development proposal
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

  Scenario: The status of a development proposal should change to 'Approval Pending' upon submission into routing
    Given I have a user with the system role: 'Proposal Creator'
    And   I initiate a development proposal
    And   I complete the proposal
    Then  I can submit the proposal document
    And   the proposal status should be Approval Pending

#TODO: Scenario: An Aggregator can blanket approve a routed proposal so its status changes to 'Approval Granted'

  Scenario: The status of a development proposal should change to 'Approval Pending - Submitted' upon submission to a sponsor
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I submit a new development proposal into routing
    When  I log in with the OSPApprover user
    And   I submit the routed proposal to a sponsor
    Then  the proposal status should be Approval Pending - Submitted

#TODO: Scenario: An OSP Approver takes the 'Submit to sponsor' action against a routed proposal and an institutional proposal is created

  Scenario: The status of a development proposal should change to 'Document Error Occurred' upon its being recalled and cancelled
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I submit a new development proposal into routing
    When  I recall and cancel the proposal
    Then  the proposal status should be 'Document Error Occurred'
  @test
  Scenario: The status of a development proposal should change to 'Revisions Requested' upon its being recalled for revisions
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I submit a new development proposal into routing
    When  I recall the proposal for revisions
    Then  the proposal status should be Revisions Requested

#=================
# Notifications -- Notifications are sent are FYIs to select users.
#=================
  Scenario: Notifications sent from a development proposal should appear as FYIs in the recipient's Action List
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a development proposal
    And   I complete the proposal
    When  I send a notification to the following users: OSPApprover
    And   I log in with the OSPApprover user
    Then  the proposal is in my action list as an FYI
    And   I can acknowledge the requested action list item

#TODO: Scenario: An OSPApprover user can filter all of their FYIs and acknowledge them at once

#=================
# Action List -- Routed proposals appear in select user's action lists with requested actions
#=================
  Scenario: An OSP Approver should receive newly submitted proposals in their action list
    Given I have a user with the system role: 'OSPApprover'
    And   I initiate a development proposal
    And   I complete the proposal
    When  I submit the proposal
    Then  the proposal is in the OSPApprover user's action list