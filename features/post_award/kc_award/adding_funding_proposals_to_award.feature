Feature: Adding Multiple Funding Proposals to an Award

  As an Award Modifier, when I add Funding Proposals to Awards,
  I want some of the Award properties to be updated automatically
  to save time and help prevent errors.

  Background:
    * a User exists with the role 'Award Modifier' in unit '000001'
    * 2 Approved Institutional Proposals with cost share, unrecovered F&A, and special review exist
    * the enable.award.FnA.validation parameter is set to 0

  Scenario: Latest Funding Proposal linked to new Award overwrites some data
    Given the Award Modifier starts an Award with the first Funding Proposal
    When  the Award Modifier adds the second Funding Proposal to the unsaved Award, merge type 'Replace'
    Then  the Title, Activity Type, and NSF Science Code match the second Funding Proposal
    But   the Sponsor ID is from the first Funding Proposal

  Scenario: Latest Funding Proposal linked to new Award overwrites data
    Given the Award Modifier starts an Award with the first Funding Proposal
    When  the Award Modifier adds the second Funding Proposal to the unsaved Award, merge type 'No Change'
    Then  the Title, Activity Type, NSF Science Code, and Sponsor still match the first Proposal

  Scenario: Latest Funding Proposal linked to new Award overwrites data
    Given the Award Modifier starts an Award with the first Funding Proposal
    When  the Award Modifier adds the second Funding Proposal to the unsaved Award, merge type 'Merge'
    Then  the Title, Activity Type, NSF Science Code, and Sponsor still match the first Proposal

  Scenario: Link Multiple Proposals, Replace
    Given the Award Modifier creates an Award with the first Funding Proposal
    When  the second Funding Proposal is added to the Award, as a replacement
    Then  the Title, Activity Type, and NSF Science Code match the second Funding Proposal
    And   the Sponsor ID is from the first Funding Proposal
    And   the Award's PI should match the PI of the second Funding Proposal
    And   the first Funding Proposal's PI is not listed in the Award's Contacts
    And   the Award's cost share data are from both Proposals
    And   the Award's special review items are from both Proposals
    And   the Award's F&A data are from both Proposals

  Scenario: Link Multiple Proposals, Merge
    Given the Award Modifier creates an Award with the first Funding Proposal
    When  the second Funding Proposal is merged to the Award
    Then  the Title, Activity Type, NSF Science Code, and Sponsor still match the first Proposal
    And   the Award's PI should match the PI of the first Funding Proposal
    And   the second Funding Proposal's PI should be a Co-Investigator on the Award
    And   the Award's cost share data are from both Proposals
    And   the Award's special review items are from both Proposals
    And   the Award's F&A data are from both Proposals

  Scenario: Link Multiple Proposals, No Change
    Given the Award Modifier creates an Award with the first Funding Proposal
    When  the second Funding Proposal is added to the Award with no change
    Then  the Title, Activity Type, NSF Science Code, and Sponsor still match the first Proposal
    And   the Award's PI should match the PI of the first Funding Proposal
    And   the second Funding Proposal's PI should not be listed on the Award
    And   the Award's cost share data are from the first Funding Proposal
    And   the Award's special review items are from the first Proposal
    And   the Award's F&A data are from the first Proposal