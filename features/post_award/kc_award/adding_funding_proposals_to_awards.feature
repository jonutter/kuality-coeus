Feature: Adding Funding Proposals to Awards

  As an Award Modifier, when I add Funding Proposals to Awards,
  I want some of the Award properties to be updated automatically
  to save time and help prevent errors.

  Background:
    Given a User exists with the role 'Award Modifier' in unit '000001'
  @bug_in_system @test
  Scenario: KC-TS-1153 Latest Funding Proposal linked to new Award overwrites data
    Given 2 Approved Institutional Proposals exist
    And   the Award Modifier starts an Award with the first Funding Proposal
    When  adds the second Funding Proposal to the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor match the second Institutional Proposal

  Scenario: KC-TS-1156 Removing a Proposal Prior to Saving Award
    Given 1 Approved Institutional Proposal exists
    Given the Award Modifier starts an Award with the Funding Proposal
    When  the Funding Proposal is removed from the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor still match the Proposal

  Scenario: KC-TS-1160 Action Availability to Delete Link
    Given 1 Approved Institutional Proposal exists
    When the Award Modifier creates an Award with the first Funding Proposal
    Then the Award Modifier cannot remove the Proposal from the Award
  @test
  Scenario: KC-TS-1154 Funding Proposal added to existing Award
    Given 1 Approved Institutional Proposal exists
    Given the Award Modifier creates an Award
    When  the Funding Proposal is added to the Award
    Then  all of the Award's details remain the same
