Feature: Proposal Actions Validations

  As a researcher I want to activate a validation check against my
  proposals to determine if they contain any errors or incomplete information.

  Background: KC user is logged in as admin
      Given   I am logged in as admin
    @test
    Scenario: Attempt to validate a proposal without a principal investigator
      When    I begin a proposal
      And     I activate a validation check
      Then    I should see a key personal information error