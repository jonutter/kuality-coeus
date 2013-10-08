Feature: Creating Proposal Logs

  As a researcher I want the ability to create a Proposal Log document
  so that my institution can initiate an Institutional Proposal record apart
  from the KC Proposal Development and Budget modules.
  @test
  Scenario: Attempt to initiate a proposal log with a missing required field
    Given a user exists with the system role: 'Create Proposal Log'
    And   I log in with the Create Proposal Log user
    When  I initiate a proposal log document but I miss a required field
    Then  an error should appear that says the field is required