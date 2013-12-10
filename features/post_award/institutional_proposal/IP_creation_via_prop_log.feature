Feature: Creating an Institutional Proposal from a Proposal Log

  In order to avoid the KC Proposal Development and Budget Module,
  as a Researcher,
  I want to create a Proposal Log Document
  so that I can generate a Prop Log ID and use it to create
  an Institutional Proposal (e.g. Funding Proposal)

  Background:
    Given a User exists with the role: 'Proposal Log Creator'

  Scenario: Attempt to initiate a Funding Proposal document w/o a required field
    Given I log in with the Proposal Log Creator user
    And   I submit a new Proposal Log
    When  I attempt to save an institutional proposal with a missing required field
    Then  an error should appear that says the field is required
  @test
  Scenario: Create a Temporary Proposal Log and merge it with an Institutional Proposal
    Given I'm logged in with dkensrue
    And   I submit a new institutional proposal document
    When  I submit a new Temporary Proposal Log
    And   I merge the temporary proposal log with the institutional proposal
    #Then  the Proposal Log's status should reflect it has been merged