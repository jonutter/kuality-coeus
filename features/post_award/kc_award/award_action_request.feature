Feature: Requesting an action from an Award

  As a user with permissions to edit an Award, I want the ability to send action requests
  to an Approver from within the Award.

  Background:
    * Users exist with the following roles: Award Modifier

<<<<<<< HEAD
=======
  #@Fixme
>>>>>>> development
  Scenario: Request the action of an Approver
    Given I create an Award as the Award Modifier user
    When  I filter the Award from my action list
    Then  I should see my Award listed with the action requested status: COMPLETE

