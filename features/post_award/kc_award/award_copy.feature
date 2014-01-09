Feature: Copying Awards

  Summary to be written

  Background:
    * a User exists with the role 'Time And Money Modifier' in unit '000001' (descends hierarchy)
    * a User exists with the role 'Award Modifier' in unit 'BL-BL'
    * I log in with that User
    * create an Award
    * add a subaward to the Award
    * complete the Award requirements
    * I log in with the Time And Money Modifier user
    * submit the Award's T&M document
    * I log in with the Award Modifier user
    * submit the Award
  @failing
  Scenario: Award copied as new Parent
    When I copy the Award to a new parent Award
    Then the new Award's transaction type is 'New'
    And  the new Award should not have any subawards or T&M document
    And  the anticipated and obligated amounts are zero
  @failing
  Scenario: Award copied to a child of itself
    When I copy the Award as a child of itself
    Then the new Award's transaction type is 'New'
    And  the child Award's project end date should be the same as the parent, and read-only
    And  the anticipated and obligated amounts are read-only and $0.00