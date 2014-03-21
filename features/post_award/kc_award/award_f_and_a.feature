Feature: Award F&A Rates

  As an Award Modifier, I want the system to help
  ensure that I don't make mistakes when entering
  F&A Rate information

  Background:
    * a User exists with the role: 'Award Modifier'
    * the Award Modifier creates an Award

  Scenario: Missing F&A Rate fields
    When  the Award Modifier adds an F&A rate to the Award but misses a required field
    Then  an error should say the field is mandatory

  Scenario: Invalid Fiscal Year
    When the Award Modifier adds an F&A rate with an invalid fiscal year
    Then an error should appear that says the fiscal year is not valid
    And  the F&A's start and end date fields should contain 'not found'

  Scenario: Percentage with 3 significant digits
    When an F&A rate is added to the Award with a Percentage having 3 significant digits
    Then an error should say that the F&A rate percentage can only have 2 decimal places