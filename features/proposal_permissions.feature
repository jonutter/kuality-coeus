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
    When    I assign mwmartin as a <Role> to the proposal permissions
    Then    That person can access the proposal
    And     can <Permissions>

    Examples:
    | Role             | Permissions                                    |
    | Narrative Writer | only update the Abstracts and Attachments page |
    | Aggregator       | edit all parts of the proposal                 |
    | Budget Creator   | only update the budget                         |
    | Viewer           | only read the proposal                         |
    | Deleter          | delete the proposal                            |
  @test
  Scenario: Adding an Approver
    Given   I have a user with the user name kctestuser17
    And     I log in with kctestuser17
    And     I initiate a proposal
    When    I add tdurkin as an approver to the proposal
    And     I complete the proposal
    And     I submit the proposal
    Then    That person can access the proposal
    And     can approve the proposal

  Scenario: A person's role can be edited
    Given   I assign a person a role
    When    I change that person's role
    Then    That person can access the proposal
    And     Their permissions reflect their newly assigned role