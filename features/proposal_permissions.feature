Feature: Permissions in a Proposal

  As a researcher, I want to be able to assign others permissions to a proposal,
  to allow them to work on the proposal with me, and to control what actions
  they are capable of performing with it.

  Background: A user has started a proposal
    Given   I'm logged in with admin

  Scenario: The proposal initiator is automatically an aggregator
    Given   I initiate a proposal
    When    I visit the proposal's Permissions page
    Then    admin is listed as an Aggregator for the proposal

  Scenario Outline: Adding various roles to proposals
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

  Scenario: Error when Aggregator role is designated among others
    Given I have a user with a system role of 'Aggregator'
    And   I initiate a proposal
    And   I assign the Aggregator user as an aggregator to the proposal permissions
    When  I attempt to add an additional role to the Aggegator user
    Then  I should see an error message that says not to select other roles alongside aggregator

  Scenario: User with Proposal Approver permission sees proposal in their action list
    Given I have a user with a system role of 'OSPApprover'
    And   I initiate a proposal
    And   I complete the proposal
    When  I submit the proposal
    Then  the proposal is in the OSPApprover user's action list

  Scenario: User with proposal Aggregator right can recall a proposal for revisions
    Given I have a user with a system role of 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I complete a valid simple proposal for a 'Private Profit' organization
    And   I submit the proposal
    When  I recall the proposal to my action list
    Then  the proposal is in the Proposal Creator user's action list
    And   when the proposal is opened the status is 'Revisions Requested'
  @test
  Scenario: User with proposal Aggregator right can recall a proposal for cancellation
    Given I have a user with a system role of 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I complete a valid simple proposal for a 'Private Profit' organization
    And   I submit the proposal
    When  I recall and cancel the proposal
    Then  when I revisit the proposal its status should be 'Document Error Occurred'
    #TODO: Write steps to check for uneditable pages in the proposal doc
