Feature: Award F&A Rates

  As an Award Modifier, I want the system to help
  ensure that I don't make mistakes when entering
  F&A Rate information

  Background:
    * a User exists with the role: 'Award Modifier'
    * the Award Modifier creates an Award

  Scenario: Missing F&A Rate fields
    When  the Award Modifier adds an F&A rate to the Award but misses a required field
    Then  an error should appear saying the field is required

  Scenario: Invalid Fiscal Year
    When the Award Modifier adds an F&A rate with an invalid fiscal year
    Then an error should appear that says the fiscal year is not valid

  Scenario: Percentage with 3 significant digits
    When an F&A rate is added to the Award with a Percentage having 3 significant digits
    Then an error should say that the F&A rate percentage can only have 2 decimal places

  Scenario: Default dates based on entered fiscal year
    When the Award Modifier adds an F&A rate to the Award
    Then the default start and end dates are based on the F&A rate's fiscal year

  Scenario: Reloading deleted rate lines
    Given the Award Modifier adds several F&A rates to the Award
    And   saves the document
    And   deletes a couple of the Award's F&A rates
    When  the Award Modifier reloads the document
    Then  the deleted F&A rates are restored to the Award