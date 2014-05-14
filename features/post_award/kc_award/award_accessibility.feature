Feature: Accessing Awards (Permissions, Rights, Access)

  Summary to be written

  Scenario: Investigator attempts to access an award without Award Viewer permissions
    Given Users exist with the following roles: Unassigned, Award Modifier
    And   the Award Modifier creates an Award
    And   adds the Unassigned user as a Principal Investigator for the Award
    When  the Unassigned user visits the Award
    Then  an error notification will indicate that the user cannot access the Award
  @test
  Scenario: Visit an unfinalized Award from the Award Lookup page
    Given a User exists with the role: 'Award Modifier'
    And   the Award Modifier creates an Award
    When  the Award Modifier searches for the Award from the award lookup page
    Then  no results should be returned