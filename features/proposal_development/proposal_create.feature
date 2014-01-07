Feature: Creating a proposal development document

  As a researcher I want the ability to create a proposal
  so that I can get funding for my research.

  Background: Logged in with a proposal creator user
    * a User exists with the role: 'Proposal Creator'
    * I log in with the Proposal Creator user

  Scenario: Attempt to save a proposal missing a required field
    When  I create a Proposal but miss a required field
    Then  I should see an error that says the field is required

  Scenario: Attempt to save a proposal with an invalid sponsor code
    When  I create a Proposal with an invalid sponsor code
    Then  I should see an error that says a valid sponsor code is required

  Scenario: Successful initiation of proposal with federal sponsor type
    When  I create a Proposal with a 'Federal' sponsor type
    Then  The S2S tab should become available
