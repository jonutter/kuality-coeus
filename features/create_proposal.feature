Feature: Creating a proposal

  As a researcher I want to create a proposals so that I can get funding for my research.

  Background: KC user is logged in as admin
      Given   I am logged in as admin

    Scenario Outline: Attempt to update a proposal while leaving the required text-fields null
      When    I begin a proposal without a <Field Name>
      Then    I should see an error that says <Error>

      Scenarios:
        | Field Name          | Error                                     |
        | Description         | Document Description is a required field. |
        | Project Title       | Project Title is a required field.        |
        | Sponsor Code        | Sponsor Code is a required field.         |
        | Project Start Date  | Project Start Date is a required field.   |
        | Project End Date    | Project End Date is a required field.     |

    Scenario Outline: Attempt to update a proposal while leaving the required select-lists null
      When    I begin a proposal without selecting a <Select List>
      Then    I should see an error that says <Error>

      Scenarios:
        | Select List   | Error                              |
        | Proposal Type | Proposal Type is a required field. |
        | Activity Type | Activity Type is a required field. |