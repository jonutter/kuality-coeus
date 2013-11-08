Feature: Copying Awards

  Summary to be written

  Background:
    Given a user exists with the role 'Time And Money Modifier' in unit '000001' (descends hierarchy)
    And   a user exists with the role 'Award Modifier' in unit 'BL-BL'
    And   I log in with that user
    And   initiate an Award

  @test
  Scenario: Award Modifier adds a PI for another unit to an Award
    Given I add a Subaward to the Award
    And   add a PI to the Award
    And   add a key person to the Award
    And   complete the Award requirements
    And   I log in with the 'Time And Money Modifier' user
    And   submit the Award's T&M document
    And   I log in with the Award Modifier user
    And   submit the Award
    And   I copy the Award to a new parent Award
    Then  the new Award should not have any Subawards