Feature: Creating an award document

  As a researcher I want the ability to create and modify an Award document (aka KC Award)
  so that I can track and maintain my funded awards.

  @test
  Scenario: Attempt to initiate a KC Award document with a missing required field
    Given a user exists with the system role: 'Award Modifier'
    And   I log in with the Award Modifier user
    When  I initiate an award document with a missing required field
    Then  an error should appear that says the field is required


