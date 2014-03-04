Feature: Basic validations for Development Proposals

  As a researcher I want the ability to see an error whenever I miss
  a required field/parameter during the creation of a Proposal.

  Background: Logged in with a proposal creator user
    * a User exists with the role: 'Proposal Creator'

  Scenario: Attempt to save a proposal missing a required field
    When  the Proposal Creator creates a Proposal while missing a required field
    Then  an error notification appears to indicate the field is required

  Scenario: Attempt to save a proposal with an invalid sponsor code
    When  the Proposal Creator creates a Proposal with an invalid sponsor code
    Then  an error should appear that says a valid sponsor is required

  Scenario: Sponsor deadline date is missing
    Given the Proposal Creator creates a Proposal without a sponsor deadline date
    When  I activate a validation check
    Then  an error should appear on the proposal page indicating the deadline date is missing

  Scenario: A PI has not been added to the proposal
    Given the Proposal Creator creates a Proposal
    And   the Proposal has no principal investigator
    When  I activate a validation check
    Then  an error appears on the key personnel page that indicates a PI is required

  Scenario Outline: Investigators is added but not certified
    Given the Proposal Creator creates a Proposal with an un-certified <Person>
    When  I activate a validation check
    Then  an error appears on the key personnel page that indicates the personnel needs certification

  Examples:
    | Person                  |
    | Co-Investigator         |
    | Principal Investigator  |
  @test
  Scenario: A Key Person is added but not certified
    Given the Proposal Creator creates a Proposal where the un-certified key person has included certification questions
    When  I activate a validation check
    Then  an error appears on the key personnel page that indicates the personnel needs certification