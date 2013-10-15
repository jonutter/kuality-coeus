Feature: Creating Proposal Logs

  As a researcher I want the ability to create a Proposal Log document
  so that my institution can initiate an Institutional Proposal record apart
  from the KC Proposal Development and Budget modules.

  Scenario: Attempt to initiate a new proposal log with a missing required field
    Given a user exists with the system role: 'Create Proposal Log'
    And   I log in with the Create Proposal Log user
    When  I initiate a proposal log document but I miss a required field
    Then  an error should appear that says the field is required

  Scenario: Initiate a new proposal log document
    Given a user exists with the system role: 'Create Proposal Log'
    And   I log in with the Create Proposal Log user
    When  I initiate a new proposal log document
    Then  the status of the proposal log document should be INITIATED
    And   the proposal log status should be Pending
  @test
  Scenario: Combine two proposal log documents
    Given users exist with the following roles: Create Proposal Log, Proposal Log PI
    And   I log in with the Create Proposal Log user
    And   initiate a new proposal log document
    When  I initiate a second new proposal log document
    And   I combine the two proposal log documents
    Then  the status of the proposal log document should be MERGED


  Scenario: Create a Temporary proposal log and convert it into a proposal development document

  Scenario: Create a Permanent proposal log and link it to a funding proposal document

