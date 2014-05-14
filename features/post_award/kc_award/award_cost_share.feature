Feature: Award Cost Sharing

  As an Award Modifier, I want the system to help
  ensure that I don't make mistakes when entering
  Cost Sharing information

  Background:
    * a User exists with the role: 'Award Modifier'
    * the Award Modifier creates an Award

  Scenario: Non-numeric project period value
    When a cost share item is added to the Award with a typo in the project period
    Then an error should appear that says the project period has a typo

  Scenario: Percentage with 3 significant digits
    When a cost share item is added to the Award with a Percentage having 3 significant digits
    Then an error should say that the cost share percentage can only have 2 decimal places

  Scenario: Add a Cost Share but miss a required field
    When a cost share item is added to the Award without a required field
    Then an error should appear saying the field is required

  Scenario: Add duplicate cost share lines
    Given duplicate cost share items are added to the Award
    When  data validation is turned on for the Award
    Then  an error is shown that says there are duplicate cost share lines