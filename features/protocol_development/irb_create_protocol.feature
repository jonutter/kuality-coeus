Feature: Creating IRB Protocols

  As a researcher I want the ability to create a protocol for human subjects

  Scenario: Attempt to save an IRB protocol missing a required field
    Given users exist with the following roles: Protocol Creator
    And   I log in with the Protocol Creator user
    When  I initiate an irb protocol but I miss a required field
    Then  an error should appear that says the field is required

  Scenario: Attempt to save a proposal with an invalid lead unit
    Given users exist with the following roles: Protocol Creator
    And   I log in with the Protocol Creator user
    When  I initiate a proposal with an invalid lead unit code
    Then  I should see an error that says my lead unit code is invalid

