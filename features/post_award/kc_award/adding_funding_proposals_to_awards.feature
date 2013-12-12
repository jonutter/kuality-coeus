Feature: Adding Funding Proposals to Awards

  TBD

  Background:
    Given a User exists with the role 'Award Modifier' in unit '000001'
    And   at least 2 Approved Institutional Proposals exist
  @bug_in_system
  Scenario: KC-TS-1153 Latest Funding Proposal linked to new Award overwrites data
    Given the Award Modifier starts an Award with the first institutional proposal number
    When  the second institutional proposal number is added to the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor match the second Institutional Proposal
  @test
  Scenario: KC-TS-1154 Funding Proposal added to existing Award
    Given the Award Modifier creates an Award
    When  one of the Funding Proposals is added to the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor remain the same

