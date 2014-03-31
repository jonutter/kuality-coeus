Feature: Basic Error Validations for Institutional Proposals

  As one who maintains Institutional Proposal docs,
  I expect to see error notifications throughout the IP workflow
  in situations where I miss a required field, enter invalid characters, etc.

  Background:
    * a User exists with the roles: Create Proposal Log, Institutional Proposal Maintainer in the 000001 unit
  @test
  Scenario: Attempt to create a Funding Proposal document w/o a required field
    Given the Create Proposal Log user creates an institutional proposal with a missing required field
    Then  an error should appear on the page to indicate the field is required

  Scenario: Attempt to add a cost sharing element w/o a required field
    Given 1 Approved Institutional Proposal exists
    When  the Institutional Proposal Maintainer adds a cost sharing element with a missing required field
    Then  a cost sharing error should appear on the distribution page to indicate the field is required

  Scenario: Filling out cost share amount fields with invalid entries
    Given 1 Approved Institutional Proposal exists
    When  the Institutional Proposal Maintainer enters invalid characters for a cost sharing element
    Then  an error should appear on the distribution page indicating that the entries are invalid

  Scenario: Attempt to add an unrecovered f&a element w/o required field
    Given 1 Approved Institutional Proposal exists
    When  the Institutional Proposal Maintainer adds an unrecovered f&a element with a missing required field
    Then  an unrecovered f&a error should appear on the distribution page to indicate the field is required

  Scenario: Filling out cost unrecovered f&a fields with invalid entries
    Given 1 Approved Institutional Proposal exists
    When  the Institutional Proposal Maintainer enters invalid characters for an unrecovered f&a element
    Then  an error should appear on the distribution page indicating that the entries are invalid

  Scenario: Filling out fiscal year with an invalid year
    Given 1 Approved Institutional Proposal exists
    When  the Institutional Maintainer enters an invalid year for the fiscal year field
    Then  an error should appear that says the fiscal year needs to be corrected
