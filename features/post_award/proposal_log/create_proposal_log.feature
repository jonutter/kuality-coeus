Feature: Creating Proposal Logs

  As a researcher I want the ability to create a Proposal Log document
  so that my institution can initiate an Institutional Proposal record apart
  from the KC Proposal Development and Budget modules.

  Background:
    Given a user exists with the system role: 'Create Proposal Log'
    And   I log in with the Create Proposal Log user

  Scenario: Attempt to initiate a new Proposal Log Document with a missing required field
    When  I initiate a Proposal Log but I miss a required field
    Then  an error should appear that says the field is required

  Scenario: Initiate a new Proposal Log Document
    When  I initiate a Proposal Log
    Then  the status of the Proposal Log should be INITIATED
    And   the Proposal Log status should be Pending

  Scenario: Merge a new Proposal Log with an existing Temporary Proposal Log
    And   submit a new temporary proposal log document with the PI cjensen
    When  I submit a new permanent proposal log document with the same PI into routing
    And   I merge my new proposal log with my previous temporary proposal log
    Then  the proposal log type of the proposal log document should be Merged