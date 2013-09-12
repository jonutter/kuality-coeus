Feature: Roles Administration

  As an administrator, I want to be able to set up
  roles in the system, so that I can control what
  the system users can do.

  Scenario: Adding an unassigned user to a Group in a Proposal Aggregator Role
    Given I'm in as the admin
    And   I create a group
    And   create an 'unassigned' user
    And   create a role with permission to create proposals
    And   add the group to the role
    When  I add the user to the group
    Then  the user should be able to create a proposal