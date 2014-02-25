Feature: Creating Proposal Logs

  As a researcher I want the ability to create a Proposal Log document
  so that my institution can create an Institutional Proposal record apart
  from the KC Proposal Development and Budget modules.

  Background:
    * a User exists with the role: 'Create Proposal Log'

  Scenario: Attempt to create a new Proposal Log Document with a missing required field
    Given the Create Proposal Log user creates a Proposal Log but misses a required field
    When  the Create Proposal Log user submits the Proposal Log
    Then  an error should appear on the page to indicate the field is required

  Scenario: Create a new Proposal Log Document
    When  the Create Proposal Log user creates a Proposal Log
    Then  the status of the Proposal Log should be INITIATED
    And   the Proposal Log status should be Pending

  Scenario: Merge a new Proposal Log with an existing Temporary Proposal Log
    And   I submit a new temporary Proposal Log with a particular PI
    When  the Create Proposal Log user submits a new permanent Proposal Log with the same PI into routing
    And   I merge my new proposal log with my previous temporary proposal log
    Then  the Proposal Log type should be Merged