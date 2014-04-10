Feature: Award Versions

  Summary to be written

  Background:
    * a User exists with the role 'Time And Money Modifier' in unit '000001' (descends hierarchy)
    * a User exists with the role 'Award Modifier' in unit 'BL-BL'
    * the Award Modifier creates an Award
    * adds a subaward to the Award
    * completes the Award requirements
    * the Time & Money Modifier submits the Award's T&M document
    * the Award Modifier user submits the Award

  Scenario: Editing finalized Award when a pending new version exists, select 'yes'
    Given the Award Modifier edits the finalized Award
    When  the original Award is edited again
    Then  a confirmation screen asks if you want to edit the existing pending version
    And   selecting 'yes' takes you to the pending version

  Scenario: Editing finalized Award when a pending new version exists, select 'no'
    Given the Award Modifier edits the finalized Award
    When  the original Award is edited again
    Then  selecting 'no' on the confirmation screen creates a new version of the Award

  Scenario:
    Given the Award Modifier edits the finalized Award
    And   the Time And Money Modifier initializes the Award's Time And Money document