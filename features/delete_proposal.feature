Feature: Deleting a proposal

  Background: [insert text here]

  Scenario: Delete a Proposal
    Given I am logged in as admin
    And   I create a proposal
    When  I delete the proposal
    Then  The proposal is deleted