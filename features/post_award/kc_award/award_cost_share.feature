Feature: Award Cost Sharing

  Text TBD

  Background:
    * a User exists with the role: 'Award Modifier'
    * the Award Modifier creates an Award

  Scenario: Non-numeric project period value
    When a cost share item is added to the Award with a typo in the project period
    Then an error should appear that says the project period has a typo

  Scenario: Percentage with 3 significant digits
    When a cost share item is added to the Award with a Percentage having 3 significant digits
    Then an error should say that the cost share percentage can only have 2 decimal places
  @test
  Scenario: Add a Cost Share but miss a required field
    When a cost share item is added to the Award without a required field
    Then an error should appear indicating the field is required