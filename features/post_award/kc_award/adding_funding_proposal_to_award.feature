Feature: Adding a Funding Proposal to an Award

  As an Award Modifier, when I add a Funding Proposal to an Award,
  I want some of the Award properties to be updated automatically
  to save time and help prevent errors.

  Background:
    * a User exists with the role 'Award Modifier' in unit '000001'
    * 1 Approved Institutional Proposal exists

  Scenario: Award Fields Remain Editable
    When  the Award Modifier starts an Award with the Funding Proposal
    Then  all Award fields remain editable

  Scenario: KC-TS-1156 Removing a Proposal Prior to Saving Award
    Given the Award Modifier starts an Award with the Funding Proposal
    When  the Funding Proposal is removed from the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor still match the Proposal
  @test
  Scenario: KC-TS-1160 Action Availability to Delete Link
    When the Award Modifier creates an Award with the Funding Proposal
    Then the Award Modifier cannot remove the Proposal from the Award

  Scenario Outline: Funding Proposal added to existing Award with Merge Type
    Given the Award Modifier creates an Award
    When  the Funding Proposal is added to the Award with '<Merge Type>'
    Then  <Expected Result>

  Examples:
    | Merge Type | Expected Result                                        |
    | No Change  | all of the Award's details remain the same             |
    | Merge      | all of the Award's details remain the same             |
    | Replace    | all the Award's details are updated except the Sponsor |