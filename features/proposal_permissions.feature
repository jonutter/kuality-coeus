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
    Given   I have a user with the user name kctestuser7
    And     I initiate a proposal
    When    I assign kctestuser7 as a <Role> to the proposal permissions
    Then    kctestuser7 can access the proposal
    And     their proposal permissions allow them to <Permissions>

    Examples:
    | Role                     | Permissions                                    |
    | Narrative Writer         | only update the Abstracts and Attachments page |
    | Aggregator               | edit all parts of the proposal                 |
    | Budget Creator           | only update the budget                         |
    | Deleter                  | delete the proposal                            |
    | Viewer                   | only read the proposal                         |

  Scenario Outline: Test
    Given I have a user with the user name unassigneduser
    And   I initiate a proposal
    And   I add unassigneduser as a <Role> to the proposal permissions
    When  I initiate a second proposal
    Then  unassigneduser should not be listed as a <Role> in the second proposal

  Examples:
    | Role             |
    | Viewer           |
    | Budget Creator   |
    | Narrative Writer |
    | Aggregator       |
    | approver         |
    | Delete Proposal  |

  Scenario: Error when Aggregator role is designated among others
    Given I have a user with the user name kctestuser10
    And   I initiate a proposal
    And   I assign kctestuser10 as an aggregator to the proposal permissions
    When  I attempt to add an additional role to kctestuser10
    Then  I should see an error message that says not to select other roles alongside aggregator

  Scenario: User with Proposal Approver permission sees proposal in their action list
    Given I have a user with a role of 'OSPApprover'
    And   I initiate a proposal
    And   I complete the proposal
    When  I submit the proposal
    Then  the proposal is in OSPApprover's action list
  @test
  Scenario: User with Aggregator role can recall a proposal for revisions
    Given I have a user with the user name kctestuser9
    And   I log in with kctestuser9
    And   I complete a valid simple proposal for a 'Private Profit' organization
    And   I submit the proposal
    When  I recall the proposal to my action list
    Then  the proposal is in kctestuser9's action list
    And   when the proposal is opened the status is 'Revisions Requested'