Feature: Award F&A Rates

  As an Award Modifier, I want the system to help
  ensure that I don't make mistakes when entering
  F&A Rate information

  Scenario: Missing F&A Rate fields
    Given a User exists with the role: 'Award Modifier'
    And   the Award Modifier creates an Award
    When  the Award Modifier adds an F&A rate to the Award but misses a required field
    Then  an error should say the field is mandatory