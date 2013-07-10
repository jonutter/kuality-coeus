Feature: Permissions in a Proposal

  As a Proposal Aggregator, I want to be able to assign others permissions to a proposal,
  to allow them to work on the proposal with me, and to control what actions
  they are capable of performing with it.

  Background: The admin user initiates a proposal
    Given I'm logged in with admin
    And   I initiate a proposal

  Scenario: The proposal initiator is automatically an aggregator
    Given I have a user with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    When  I visit the proposal's Permissions page
    Then  the Proposal Creator user is listed as an Aggregator in the proposal permissions

  Scenario Outline: A Proposal Aggregator can assign various roles to a proposal documents permissions
    Given I have a user with the system role: 'Unassigned'
    When  I assign the Unassigned user as a <Role> in the proposal permissions
    Then  the Unassigned user can access the proposal
    And   their proposal permissions allow them to <Permissions>

    Examples:
    | Role                     | Permissions                                    |
    | Narrative Writer         | only update the Abstracts and Attachments page |
    | Aggregator               | edit all parts of the proposal                 |
    | Budget Creator           | only update the budget                         |
    | Delete Proposal          | delete the proposal                            |
    | Viewer                   | only read the proposal                         |

  Scenario Outline: Proposal permissions are not passed onto future proposals initiated by the same creator
    Given I have a user with the system role: 'Unassigned'
    And   I assign the Unassigned user as a <Role> in the proposal permissions
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

  Scenario: Users who are assigned the Aggregator role cannot be assigned additional roles
    Given I have a user with the system role: 'Unassigned'
    And   I assign the Unassigned user as an aggregator in the proposal permissions
    When  I attempt to add an additional proposal role to the Aggregator user
    Then  I should see an error message that says not to select other roles alongside aggregator

  Scenario: A proposal document cannot have multiple users assigned to the Aggregator role
    Given I have a user with the system role: 'Proposal Creator'
    And   I assign the Proposal Creator user as an aggregator in the proposal permissions
    When  I attempt to add an additional proposal role to the Aggregator user
    Then  I should see an error message that says not to select other roles alongside aggregator

  Scenario Outline: Users with the appropriate permissions can edit proposals that have been recalled for revisions
    Given I have a user with the system role: 'Unassigned'
    And   I assign the Unassigned user as a <Role> in the proposal permissions
    And   I complete the proposal
    And   I submit the proposal
    When  I recall the proposal for revisions
    Then  the Unassigned user can access the proposal
    And   their proposal permissions allow them to <Permissions>

  Examples:
    | Role                | Permissions                                    |
    | Narrative Writer    | only update the Abstracts and Attachments page |
    | Aggregator          | edit all parts of the proposal                 |
    | Budget Creator      | only update the budget                         |
    | Delete Proposal     | delete the proposal                            |
    | Viewer              | only read the proposal                         |