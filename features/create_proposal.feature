Feature: creating a proposal

  Background: Admin user creates proposal
    Given I am logged in as admin
    And I create a proposal

    #Scenario: Successfully Create a Proposal
    #  Then  It's created

    Scenario: Create a proposal with a Principle Investigator
      And I add a Principal Investigator to the proposal, named Jeff Covey
      Then It's created
