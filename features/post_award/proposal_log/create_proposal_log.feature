Feature: Creating Proposal Logs

  As a researcher I want the ability to create a Proposal Log document
  so that my institution can initiate an Institutional Proposal record apart
  from the KC Proposal Development and Budget modules.

  Scenario: Attempt to initiate a new Proposal Log Document with a missing required field
    Given a user exists with the system role: 'Create Proposal Log'
    And   I log in with the Create Proposal Log user
    When  I initiate a proposal log document but I miss a required field
    Then  an error should appear that says the field is required
  @test
  Scenario: Initiate a new Proposal Log Document
    Given a user exists with the system role: 'Create Proposal Log'
    And   I log in with the Create Proposal Log user
    When  I initiate a new proposal log document
    Then  the status of the proposal log document should be INITIATED
    And   the proposal log status should be Pending

  Scenario: Merge a new Proposal Log Document with an existing temporary proposal log
    Given users exist with the following roles: Create Proposal Log
    And   I log in with the Create Proposal Log user
    And   initiate a new temporary proposal log document
    When  I initiate a second new proposal log document
    And   I combine the two proposal log documents
    Then  the status of the proposal log document should be MERGED

  Scenario: Create a Temporary proposal log and convert it into a proposal development document
    Given users exist with the following roles: Create Proposal Log
    And   I log in with the Create Proposal Log user
    And   initiate a new proposal log document

  Scenario: Merge a Temporary Proposal Log with an Institutional Proposal
    Given users exist with the following roles: Create Proposal Log, OSP Administrator
    And   I log in with the Create Proposal Log user
    And   I initiate a new temporary proposal log document
    When  I log in with the OSP Administrator user
    And   I initiate a new institutional proposal document
    And   I merge the temporary proposal log with the institutional proposal


  Scenario: Attempt to merge a Permanent Proposal log with an Institutional Proposal
    Given users exist with the following roles: Create Proposal Log, OSP Administrator
    And   I log in with the Create Proposal Log user
    And   I initiate a new permanent proposal log document
    When  I log in with the OSP Administrator user
    And   I initiate a new institutional proposal document
    And   I merge the temporary proposal log with the institutional proposal