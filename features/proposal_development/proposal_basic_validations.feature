Feature: Basic validations for Development Proposals

  As a researcher I want the ability to see an error whenever I miss
  a required field/parameter during the creation of a Proposal.

  Background: Logged in with a proposal creator user
    * a User exists with the role: 'Proposal Creator'

  Scenario: Attempt to save a proposal missing a required field
    When  the Proposal Creator creates a Proposal while missing a required field
    Then  an error notification appears to indicate the field is required
  @test
  Scenario: Attempt to save a proposal with an invalid sponsor code
    When  the Proposal Creator creates a Proposal with an invalid sponsor code
    Then  an error should appear that says a valid sponsor is required

#  Scenario: Sponsor deadline date is missing
#    Given the Proposal
#
#  Scenario: A PI has not been added to the proposal
#
#  Scenario Outline: Investigators is added but not certified
#
#  Examples:
#    | Person                  |
#    | Co-Investigator         |
#    | Principal Investigator  |
#
#  Scenario: A Key Person is added but not certified
#    Given the Proposal Creator creates a Proposal while