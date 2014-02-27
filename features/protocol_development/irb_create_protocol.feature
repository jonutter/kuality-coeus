Feature: Creating IRB Protocols

  As a researcher I want the ability to create a protocol for human subjects

  Background: Establish a Protocol Creator
    * a User exists with the role: 'Protocol Creator'

  Scenario: Attempt to save an IRB protocol missing a required field
    Given the Protocol Creator user creates an irb protocol but I miss a required field
    Then  an error should appear that says the field is required for the Protocol

  Scenario: Attempt to save a proposal with an invalid lead unit
    Given Users exist with the following roles: Protocol Creator
    And   the Protocol Creator user creates a proposal with an invalid lead unit code
    Then  an error for the invalid unit code appears

