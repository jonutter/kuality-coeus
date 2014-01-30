Feature: Adding Multiple Funding Proposals to an Award

  As an Award Modifier, when I add Funding Proposals to Awards,
  I want some of the Award properties to be updated automatically
  to save time and help prevent errors.

  Background:
    * a User exists with the role 'Award Modifier' in unit '000001'
    * 2 Approved Institutional Proposals exist
  @test
  Scenario: KC-TS-1153 Latest Funding Proposal linked to new Award overwrites data
    Given the Award Modifier starts an Award with the first Funding Proposal
    When  adds the second Funding Proposal to the unsaved Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor match the second Institutional Proposal
  #@test
  Scenario: Link Multiple Proposals, Replace
    Given the Award Modifier creates an Award with the first Funding Proposal
    When  the second Funding Proposal is added to the Award, as a replacement
    Then  the Title, Activity Type, and NSF Science Code match the second Institutional Proposal
    And   the Sponsor ID is from the first Funding Proposal
    And   the Award's PI should match the PI of the second Funding Proposal
    And   the first Funding Proposal's PI is not listed in the Award's Contacts

  Scenario: Link Multiple Proposals, Merge
    Given the Award Modifier creates an Award with the first Funding Proposal
    When  the second Funding Proposal is merged to the Award
    Then  what?

  Scenario: Link Multiple Proposals, No Change
    Given the Award Modifier creates an Award with the first Funding Proposal
    When  the second Funding Proposal is added to the Award with no change
    Then  the Title, Activity Type, NSF Science Code, and Sponsor still match the first Proposal
    And   what?