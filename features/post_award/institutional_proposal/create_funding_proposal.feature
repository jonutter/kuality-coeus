Feature: Creating an Institutional Proposal AKA Funding Proposal

  As an Administrator, I want the ability to create an institutional proposal
  so that I may enter and maintain proposal, sponsor, and award information.

#Note: Funding proposal documents can be created either by submitting a
#Proposal Development document, or by promoting a Proposal Log document

  Scenario: Attempt to initiate a Funding Proposal document w/o a required field

  Scenario: Create a Temporary Proposal Log and merge it with an Institutional Proposal
    Given I'm logged in with dkensrue
    And   I submit a new institutional proposal document
    When  I submit a new temporary proposal log document
    And   I merge the temporary proposal log with the institutional proposal
    Then  the proposal log's status should reflect it has been merged

  Scenario: Initiate a Funding Proposal document by submitting a Proposal Development document

  Scenario: Initiate a Funding Proposal document by promoting a Proposal Log document