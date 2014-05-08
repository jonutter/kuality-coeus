Feature: Creating IRB Protocols

  As a researcher I want the ability to create a protocol for human subjects

  Background: Establish a Protocol Creator
    * a User exists with the role: 'Protocol Creator'

  Scenario: Attempt to save an IRB protocol missing a required field
    Given the Protocol Creator user creates an irb protocol but I miss a required field
    Then  an error should appear saying the field is required

  Scenario: Attempt to save a proposal with an invalid lead unit
    Given the Protocol Creator user creates a proposal with an invalid lead unit code
    Then  an error is shown that indicates the lead unit code is invalid

