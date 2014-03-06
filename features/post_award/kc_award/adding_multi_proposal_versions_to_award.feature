Feature: Adding Multiple Funding Proposal Versions to an Award

  As an Award Modifier, I want the ability to add multiple versions
  of a Funding Proposal to my Awards.

  Scenario: KC-TS-1143 Can Link Multiple Versions of One Proposal
    Given a User exists with the role: 'Award Modifier'
    And   2 versions of an Institutional Proposal exist
    When  the Award Modifier creates an Award with the first version of the Funding Proposal
    Then  the second version of the Funding Proposal can be added to the Award