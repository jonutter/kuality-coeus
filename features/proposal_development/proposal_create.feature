Feature: Creating a proposal development document

  As a researcher I want the ability to create a proposal
  so that I can get funding for my research.

  Background: Logged in with a proposal creator user
    * a User exists with the role: 'Proposal Creator'

  Scenario: Successful initiation of proposal with federal sponsor type
    When  the Proposal Creator creates a Proposal with a 'Federal' sponsor type
    Then  The S2S tab should become available
