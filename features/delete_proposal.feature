Feature: Deleting a proposal

  As an Admin I want to be able to delete proposals for various reasons.
  @test
  Scenario: Delete a Proposal
    Given   I am logged in as an admin
    And     I begin a proposal
    When    I delete the proposal
    Then    The proposal is deleted

  Scenario: A submitted proposal can no longer be deleted
    When    I submit the proposal to routing
    Then    The proposal cannot be deleted