Feature: Requesting an action from an Award

  As a user with permissions to edit an Award, I want the ability to send action requests
  to an Approver from within the Award.

  Background:
    * Users exist with the following roles: Award Modifier

  Scenario: Request the action of an Approver
    Given the Award Modifier creates an Award
    When  I filter the action list to find the Award
    Then  I should see the Award listed with the action requested status: COMPLETE