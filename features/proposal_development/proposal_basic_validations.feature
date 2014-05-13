Feature: Basic validations for Development Proposals

  As a researcher I want the ability to see an error whenever I miss
  a required field/parameter during the creation of a Proposal.

  Background: Logged in with a proposal creator user
    * a User exists with the role: 'Proposal Creator'

  Scenario: Attempt to save a proposal missing a required field
    When  the Proposal Creator creates a Proposal while missing a required field
    Then  an error should appear saying the field is required

  Scenario: Attempt to save a proposal with an invalid sponsor code
    When  the Proposal Creator creates a Proposal with an invalid sponsor code
    Then  an error should appear that says a valid sponsor is required
#  @failing
#  Scenario: Sponsor deadline date is missing
#  @failing
#  Scenario: A PI has not been added to the proposal
#  @failing
#  Scenario Outline: Investigators is added but not certified
#
#  Examples:
#    | Person                  |
#    | Co-Investigator         |
#    | Principal Investigator  |
#  @failing
#  Scenario: A Key Person is added but not certified
#    Given the Proposal Creator creates a Proposal while