Feature: Creating an Institutional Proposal from a Proposal Log

  In order to avoid the KC Proposal Development and Budget Module,
  as a Researcher,
  I want to create a Proposal Log Document
  so that I can generate a Prop Log ID and use it to create
  an Institutional Proposal (e.g. Funding Proposal)

  Background:
    * a User exists with the roles: Create Proposal Log, Institutional Proposal Maintainer in the 000001 unit

  Scenario: Attempt to create a Funding Proposal document w/o a required field
    Given the Create Proposal Log user creates an institutional proposal with a missing required field
    Then  an error should appear saying the field is required

  Scenario: Attempt to merge a temporary Proposal Log with an Institutional Proposal
    Given 1 Approved Institutional Proposal exists
    When  the Create Proposal Log user submits a new Temporary Proposal Log
    And   the Create Proposal Log user merges the temporary proposal log with the Funding Proposal
    Then  the Proposal Log's status should reflect it has been Merged