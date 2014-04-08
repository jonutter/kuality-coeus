Feature: Sponsor Template Creation

  As a user with the Modify Sponsor Template role,
  I want the ability to create Sponsor Template Documents
  that can be linked to KC Awards.

  Background: Establish Sponsor Template user
    Given a User exists with the roles: Modify Sponsor Template, Application Administrator in the 000001 unit

  Scenario: Creating a Sponsor Template without Sponsor Template Terms
    When  I submit a new Award Sponsor Template without Sponsor Template Terms
    Then  errors about the missing terms are shown
  @test
  Scenario: test********
    When  I submit a new Sponsor Term
