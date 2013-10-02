Feature: Creating an Award

  As a researcher I want the ability to create and modify an Award document
  so that I can [fill this in]
  @test
  Scenario:
    Given users exist with the following roles: Award Modifier
    And   I log in with the Award Modifier user
    When  I initiate an award document with a missing required field
    Then  I should see an
