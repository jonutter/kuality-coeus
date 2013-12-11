Feature: Creating an Award

  As an Award Modifier I want to be able to change Awards
  so that I can make adjustments to award records
  @bug_in_system
  Scenario: KC-TS-1153 Latest Funding Proposal Linked to New Award Overwrites Data
    Given a User exists with the role 'Award Modifier' in unit '000001'
    And   at least 2 Approved Institutional Proposals exist
    And   the Award Modifier starts an Award with the first institutional proposal number
    When  the second institutional proposal number is added to the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor match the second Institutional Proposal

  Scenario: Create an award