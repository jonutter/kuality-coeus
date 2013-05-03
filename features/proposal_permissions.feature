Feature: Permissions in a Proposal

  As a researcher, I want to be able to assign others permissions to a proposal,
  to allow them to work on the proposal with me, and to control what actions
  they are capable of performing with it.

  Background: A user has started a proposal
    Given   I'm logged in with admin
    And     I initiate a proposal

  Scenario: The proposal initiator is automatically an aggregator
    Given   I initiate a proposal
    When    I visit the proposal's Permissions page
    Then    admin is listed as an Aggregator for the proposal
  @test
  Scenario Outline: Adding various roles to proposals
    Given   I have a user with the user name kctestuser6
    When    I assign kctestuser6 as a <Role> to the proposal permissions
    Then    kctestuser6 can access the proposal
    And     can <Permissions>

    Examples:
    | Role             | Permissions                                    |
    | Narrative Writer | only update the Abstracts and Attachments page |
    | Aggregator       | edit all parts of the proposal                 |
    | Budget Creator   | only update the budget                         |
    | Viewer           | only read the proposal                         |
    | Deleter          | delete the proposal                            |

  Scenario: Budget creator can edit proposal Budget Versions screen
    Given   I have a user with the user name propcreateadmin
    And     I have a user with the user name kctestuser6
    And     I log in with propcreateadmin
    And     I initiate a proposal
    And     I assign kctestuser6 as a Budget Creator to the proposal permissions
    And     I save and close the proposal document
    When    I log in with kctestuser6
    And     I visit the proposal's budget versions page
#    Then    I can add a budget
#    And     I can save and close the proposal document

  Scenario: Error when Aggregator role is designated among others

  Scenario: