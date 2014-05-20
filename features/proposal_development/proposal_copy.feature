Feature: Copying Proposal Development Documents

  As a Proposal Creator, I want to be able to copy
  Proposals so that I can save time and prevent errors.

  Scenario: Copy a Proposal to a new Lead Unit
    Given a User exists with the role: 'Proposal Creator'
    And   the Proposal Creator creates a Proposal
    And   adds a principal investigator to the Proposal
    When  the Proposal is copied to a different lead unit
    And   the new Proposal is closed and reopened
    Then  the new Proposal's lead unit is as specified
    And   the new Proposal's principal investigator has the correct lead unit