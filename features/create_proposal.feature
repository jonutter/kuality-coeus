Feature: Creating a proposal

  As a researcher I want to be able to create a proposal so that I can get funding for my research.

  Background: KC user is logged in as admin
      Given   I am logged in as admin

    Scenario Outline: Attempt to create a proposal while leaving the required text fields null
      When    I begin a proposal without a <Field Name>
      Then    I should see an error that says <Error>

      Scenarios:
        | Field Name                   | Error                                     |
        | Document Description         | Document Description is a required field. |
        | Project Title                | Project Title is a required field.        |
        | Sponsor Code                 | Sponsor Code is a required field.         |
        | Project Start Date           | Project Start Date is a required field.   |
        | Project End Date             | Project End Date is a required field.     |
        | Proposal Type                | Proposal Type is a required field.        |
        | Activity Type                | Activity Type is a required field.        |
        | Lead Unit                    | Lead Unit is a required field.            |