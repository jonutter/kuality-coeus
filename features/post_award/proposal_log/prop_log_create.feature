Feature: Creating Proposal Logs

  As a researcher I want the ability to create a Proposal Log document
  so that my institution can create an Institutional Proposal record apart
  from the KC Proposal Development and Budget modules.

  Background:
    Given a User exists with the role: 'Create Proposal Log'
    And   I log in with the Create Proposal Log user

  Scenario: Attempt to create a new Proposal Log Document with a missing required field
    When  I create a Proposal Log but I miss a required field
    Then  upon submission of the Proposal Log, an error should appear saying the field is required

  Scenario: Create a new Proposal Log Document
    When  I create a Proposal Log
    Then  the status of the Proposal Log should be INITIATED
    And   the Proposal Log status should be Pending
  @failing
  Scenario: Merge a new Proposal Log with an existing Temporary Proposal Log
    And   submit a new temporary proposal log document with the PI cjensen
    When  I submit a new permanent Proposal Log with the same PI into routing
    And   I merge my new proposal log with my previous temporary proposal log
    Then  the proposal log type of the Proposal Log should be Merged