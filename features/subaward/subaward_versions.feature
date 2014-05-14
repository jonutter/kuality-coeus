@failing
Feature: Subaward Versions

  Text TBD

  Background:
    * a User exists with the role: 'Modify Subaward'
    * the Modify Subaward user creates and submits a Subaward
    * edits the Subaward

  Scenario: Can't edit first Subaward version after second is Final
    When  the Modify Subaward user submits version 2 of the Subaward
    Then  Version 1 of the Subaward is no longer editable

  Scenario: Editing Final version, then editing again
    When the Modify Subaward user edits version one of the Subaward again
    Then they are asked if they want to edit the Subaward's existing pending version