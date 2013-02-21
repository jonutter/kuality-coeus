Feature: Deleting a proposal

  As an admin I want to be able to delete
  proposals, for various reasons.

  Scenario: Delete a Proposal
    Given I am logged in as admin
    And   I begin a proposal
    When  I delete the proposal
    Then  The proposal is deleted