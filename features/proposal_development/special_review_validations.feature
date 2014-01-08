Feature: Special Review Validation

  As a researcher I want to know if there are problems
  with my proposal's Special Review items so that I can fix them
  before I submit the proposal

  Scenario: The application date must be prior to the approval date
    Given a User exists with the role: 'Proposal Creator'
    And   the Proposal Creator creates a Proposal
    When  a special review item is added to the Proposal with an approval date earlier than the application date
    Then  I should see an error that the approval should occur later than the application