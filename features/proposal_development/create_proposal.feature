Feature: Creating proposals

  As a researcher I want the ability to create a proposal,
  so that I can get funding for my research.

  Background: Logged in with a proposal creator user
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user

  Scenario: Attempt to save a proposal missing a required field
    When  I initiate a proposal but miss a required field
    Then  I should see an error that says the field is required

  Scenario: Attempt to save a proposal with an invalid sponsor code
    When  I initiate a proposal with an invalid sponsor code
    Then  I should see an error that says a valid sponsor code is required

  Scenario: Successful initiation of proposal with federal sponsor type
    When  I initiate a proposal with a 'Federal' sponsor type
    Then  The S2S tab should become available

  Scenario: Successful submission of a Private Profit proposal document into routing
    When  I complete a valid simple proposal for a 'Private Profit' organization
    And   submit the proposal
    Then  The proposal should immediately have a status of 'Approval Pending'
    And   The proposal route log's 'Actions Taken' should include 'COMPLETED'
    And   The proposal's 'Future Action Requests' should include 'PENDING APPROVE' for the principal investigator