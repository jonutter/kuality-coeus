Feature: Permissions in a Proposal

  As a researcher, I want to be able to assign others permissions to a proposal,
  to allow them to work on the proposal with me, and to control what actions
  they are capable of performing with it.

  Background: A user has started a proposal
    Given   I am logged in as the admin
    And     I begin a proposal

  Scenario: The initiator is automatically an aggregator
    When    I visit the proposal permissions page
    Then    I am listed as an aggregator for the proposal

  Scenario Outline: Adding various roles to proposals
    When    I add a <Role> to the proposal
    Then    That person can access the proposal
    And     can <Permissions>

    Examples:
    | Role             | Permissions                                    |
    | Narrative Writer | only update the Abstracts and Attachments page |
    | Aggregator       | edit all parts of the proposal                 |
    | Budget Creator   | only update the budget                         |
    | Viewer           | only read the proposal                         |
    | Deleter          | delete the proposal                            |

  Scenario: Adding an approver
    When    I add an approver to the proposal
    And     I submit the proposal
    Then    That person can access the proposal
    And     can approve the proposal

  Scenario: A person's role can be edited
    Given   I assign a person a role
    When    I change that person's role
    Then    That person can access the proposal
    And     Their permissions reflect their newly assigned role