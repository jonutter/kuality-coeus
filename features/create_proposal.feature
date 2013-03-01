Feature: Creating a proposal

  As a researcher I want to create a proposals so that I can get funding for my research.

  Background: KC user is logged in as admin
      Given   I am logged in as admin

    Scenario Outline: Attempt to create a proposal while leaving the required text-fields null
      When    I begin a proposal without a <Field Name>
      Then    I should see an error that says "<Field Name> is a required field."

      Scenarios:
        | Field Name          |
        | Description         |
        | Proposal Type       |
        | Lead Unit           |
        | Activity Type       |
        | Project Title       |
        | Sponsor Code        |
        | Project Start Date  |
        | Project End Date    |
  @test
    Scenario: Attempt to create a proposal with invalid sponsor code
      When    I begin a proposal with an invalid sponsor code
      Then    I should see an error that says valid sponsor code required
