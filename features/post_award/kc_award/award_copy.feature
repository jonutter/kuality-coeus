Feature: Copying Awards

  Summary to be written

  # Broken until 5.21 because of T&M Modifier permissions--they can't view Awards
  Background:
    * a User exists with the role 'Time And Money Modifier' in unit '000001' (descends hierarchy)
    * a User exists with the role 'Award Modifier' in unit 'BL-BL'
    * the Award Modifier creates an Award
    * adds a subaward to the Award
    * completes the Award requirements
    * the Time & Money Modifier submits the Award's T&M document
    * the Award Modifier user submits the Award

  Scenario: Award copied as new Parent
    When I copy the Award to a new parent Award
    Then the new Award's transaction type is 'New'
    And  the new Award should not have any subawards or T&M document
    And  the anticipated and obligated amounts are zero

  Scenario: Award copied to a child of itself
    When I copy the Award as a child of itself
    Then the new Award's transaction type is 'New'
    And  the child Award's project end date should be the same as the parent, and read-only
    And  the anticipated and obligated amounts are read-only and $0.00