Feature: Basic Error Validations for Institutional Proposals

  As one who maintains Institutional Proposal docs,
  I expect to see error notifications throughout the IP workflow
  in situations where I miss a required field, enter invalid characters, etc.

  Background:
    #* a User exists with the roles: Create Proposal Log, Institutional Proposal Maintainer in the 000001 unit

  Scenario: Attempt to create a Funding Proposal document w/o a required field
    Given the Create Proposal Log user creates an institutional proposal with a missing required field
    Then  an error notification should appear to indicate the field is required
  @test
  Scenario: Attempt to add a cost sharing element w/o a required field
    Given 1 Approved Institutional Proposal exists
    #When  the Institutional Proposal Maintainer adds a cost sharing element with a missing required field
    #Then  an error indicating the field is required should appear on the cost sharing page

