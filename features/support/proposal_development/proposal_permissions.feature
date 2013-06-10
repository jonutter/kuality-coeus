Feature: Permissions in a Proposal

  As a researcher, I want to be able to assign others permissions to a proposal,
  to allow them to work on the proposal with me, and to control what actions
  they are capable of performing with it.

  Background: The admin user is signed in
    Given   I'm logged in with admin

  Scenario: The proposal initiator is automatically an aggregator
    Given I have a user with a system role of 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    When  I visit the proposal's Permissions page
    Then  Proposal Creator is listed as an Aggregator for the proposal

  Scenario Outline: Proposal creators can assign various roles to a proposal document
    Given I have a user with a system role of 'Unassigned'
    And   I initiate a proposal
    When  I assign the Unassigned user as a <Role> to the proposal permissions
    Then  the Unassigned user can access the proposal
    And   their proposal permissions allow them to <Permissions>

    Examples:
    | Role                     | Permissions                                    |
    | Narrative Writer         | only update the Abstracts and Attachments page |
    | Aggregator               | edit all parts of the proposal                 |
    | Budget Creator           | only update the budget                         |
    | Delete Proposal          | delete the proposal                            |
    | Viewer                   | only read the proposal                         |

  Scenario Outline: Permissions for one proposal do not extend to other proposals
    Given I have a user with a system role of 'Unassigned'
    And   I initiate a proposal
    And   I assign the Unassigned user as a <Role> to the proposal permissions
    When  I initiate a second proposal
    Then  the Unassigned user should not be listed as a <Role> in the second proposal

  Examples:
    | Role             |
    | Viewer           |
    | Budget Creator   |
    | Narrative Writer |
    | Aggregator       |
    | approver         |
    | Delete Proposal  |

  Scenario: Users with the Aggregator permission cannot be assigned additional roles
    Given I have a user with a system role of 'Aggregator'
    And   I initiate a proposal
    And   I assign the Aggregator user as an aggregator to the proposal permissions
    When  I attempt to add an additional role to the Aggregator user
    Then  I should see an error message that says not to select other roles alongside aggregator

  Scenario: A proposal document cannot have multiple Aggregators
    Given I have a user with a system role of 'Proposal Creator'
    And   I initiate a proposal
    And   I assign the Proposal Creator user as an aggregator to the proposal permissions
    When  I attempt to add an additional role to the Aggregator user
    Then  I should see an error message that says not to select other roles alongside aggregator

  Scenario Outline: Users with the appropriate proposal permissions can edit a proposals that have been recalled for revisions
    Given I have a user with a system role of 'Unassigned'
    And   I initiate a proposal
    And   I assign the Unassigned user as a <Role> to the proposal permissions
    And   I complete the proposal
    And   I submit the proposal
    When  I recall the proposal for revisions
    Then  the Unassigned user can access the proposal
    And   their proposal permissions allow them to <Permissions>

  Examples:
    | Role                     | Permissions                                    |
    | Narrative Writer         | only update the Abstracts and Attachments page |
    | Aggregator               | edit all parts of the proposal                 |
    | Budget Creator           | only update the budget                         |
    | Delete Proposal          | delete the proposal                            |
    | Viewer                   | only read the proposal                         |

  Scenario: Users with the Proposal Creator role can recall their proposals for revisions
    Given I have a user with a system role of 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I recall the proposal for revisions
    Then  the proposal is in the Proposal Creator user's action list
    And   when the proposal is opened the status should be 'Revisions Requested'

  Scenario: User with Proposal Creator role can recall their proposals for cancellation
    Given I have a user with a system role of 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    And   I submit the proposal
    When  I recall and cancel the proposal
    Then  the proposal status should be 'Document Error Occurred'

  Scenario: A proposal document's Aggregator can submit a proposal once completed
    Given I have a user with a system role of 'Proposal Creator'
    And   I initiate a proposal
    And   I complete the proposal
    Then  I can submit the proposal document
    And   the proposal status should be Approval Pending

  Scenario: Users with the OSP Approver role get submitted proposals routed to their action list
    Given I have a user with a system role of 'OSPApprover'
    And   I initiate a proposal
    And   I complete the proposal
    When  I submit the proposal
    Then  the proposal is in the OSPApprover user's action list

  Scenario: A proposal Aggregator user can approve a proposal that has been routed
    And     I have users with the system roles of 'OSPApprover', 'Proposal Creator', and 'Unassigned'
    And     I log in with the Proposal Creator user
    And     I initiate a proposal
    And     I add the Unassigned user as a Principal Investigator to the key personnel proposal roles
    And     I complete the proposal
    And     I submit the proposal
    When    the OSPApprover user approves the proposal
    And     I log in with the Unassigned user
    And     the Unassigned user approves the proposal
    Then    the Proposal Creator user can approve the proposal document
  @test
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

  Scenario: An OSP Approver can acknowledge an FYI
    Given I have users with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a proposal
    And   I complete the proposal
    When  I send a notification
    And   I log in with the OSPApprover user
    Then  the proposal is in the OSPApprover user's action list
    And   the OSPApprover user can acknowledge the requested action list item


