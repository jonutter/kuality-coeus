Feature: Roles Administration

  As an administrator, I want to be able to set up
  roles in the system, so that I can control what
  the system users can do.

  Scenario: Adding an unassigned user to a Group in a Proposal Aggregator Role
    Given I'm in as the admin
    And   I create a Group
    And   create an 'unassigned' User
    And   create a Role with permission to create proposals
    And   add the Group to the Role
    When  I add the User to the Group
    Then  the User should be able to create a proposal