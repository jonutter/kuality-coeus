Feature: Adding Funding Proposals to Awards

  As an Award Modifier, when I add Funding Proposals to Awards,
  I want some of the Award properties to be updated automatically
  to save time and help prevent errors.

  Background:
    Given a User exists with the role 'Award Modifier' in unit '000001'
    And   at least 2 Approved Institutional Proposals exist
  @bug_in_system
  Scenario: KC-TS-1153 Latest Funding Proposal linked to new Award overwrites data
    Given the Award Modifier starts an Award with the first institutional proposal number
    When  the second institutional proposal number is added to the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor match the second Institutional Proposal

  Scenario: KC-TS-1154 Funding Proposal added to existing Award
    Given the Award Modifier creates an Award
    When  one of the Funding Proposals is added to the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor remain the same
  @test
  Scenario: KC-TS-1156 Unlinking a Proposal Prior to Saving Award
    Given the Award Modifier starts an Award with the first institutional proposal number
    When  the Funding Proposal is removed from the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor still match the Proposal