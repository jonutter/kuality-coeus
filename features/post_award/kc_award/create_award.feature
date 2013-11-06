Feature: Creating an Award


  Background:
    Given a user exists with the system role: 'Award Modifier'
    And   I log in with that user
    And   initiate an Award
  @test
  Scenario: Add a Payment & Invoice Req before adding a PI
    When I add a Payment & Invoice item to the Award
    Then a warning appears saying tracking details won't be added until there's a PI

  # TODO: Move this item to another feature file (it doesn't fit with the Background)
  #@broken
  #Scenario: Attempt to initiate a KC Award document with a missing required field
  #  When  I initiate an award document with a missing required field
  #  Then  an error should appear that says the field is required


