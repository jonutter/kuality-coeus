Feature: Creating IRB Protocols

  As a researcher I want the ability to create a protocol for human subjects

  Background: Establish a Protocol Creator
    * a User exists with the role: 'Protocol Creator'

  Scenario: Attempt to save a proposal with an invalid lead unit
    Given the Protocol Creator user creates a Protocol with an invalid lead unit code
    Then  an error is shown that indicates the lead unit code is invalid