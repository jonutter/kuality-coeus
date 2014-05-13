Feature: Award Versions

  Summary to be written

  Background:
    * a User exists with the role 'Time And Money Modifier' in unit '000001' (descends hierarchy)
    * a User exists with the role 'Award Modifier' in unit 'BL-BL'
    * the Award Modifier creates an Award
    * adds a subaward to the Award
    * completes the Award requirements
    * the Award Modifier user submits the Award

  Scenario: Editing finalized Award when a pending new version exists, select 'yes'
    Given the Time & Money Modifier submits the Award's T&M document
    And   edits the finalized Award
    When  the original Award is edited again
    Then  a confirmation screen asks if you want to edit the existing pending version
    And   selecting 'yes' takes you to the pending version

  Scenario: Editing finalized Award when a pending new version exists, select 'no'
    Given the Time & Money Modifier submits the Award's T&M document
    And   edits the finalized Award
    When  the original Award is edited again
    Then  selecting 'no' on the confirmation screen creates a new version of the Award

  Scenario: Canceling and reopening Time And Money
    Given the Award Modifier edits the finalized Award
    And   the Time And Money Modifier initializes the Award's Time And Money document
    And   cancels the Time And Money document
    And   opens the Award
    When  the Time And Money Modifier initializes the Award's Time And Money document
    Then  the Time And Money document should not be the cancelled version

  # This test will fail until this issue is resolved: https://jira.kuali.org/browse/KRAFDBCK-10616
  #Scenario: Time And Money still final when Award edited
  #  When  the Time And Money Modifier opens the Award's Time And Money document
  #  Then  the T&M document is still the finalized version
  #  And   returning to the Award goes to the new, pending version




    #And   cancels the Time And Money document
    #When  the Award Modifier cancels the Award
    #Then  a search for the Award should return the finalized Award
    #And   the attached T&M document should be the finalized version