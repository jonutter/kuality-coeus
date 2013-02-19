Feature: creating a proposal

  Background: Admin user creates proposal
      Given   I am logged in as admin
      And     I create a proposal

    Scenario: Attempt to update proposal without description
      When    I remove the proposal description
      And     I attempt to update the proposal
      Then    I see an error that states the description is required

    Scenario Outline: Attempt to update a proposal while leaving the required fields null
      When    I clear out the content from the <Field Name> field
      And     I attempt to update the proposal
      Then    I should see an error that says <Error>

      Scenarios:
        | Field Name          | Error                                   |
        | Proposal Type       | Proposal Type is a required field.      |
        | Activity Type       | Activity Type is a required field.      |
        | Project Title       | Project Title is a required field.      |
        | Sponsor Code        | Sponsor Code is a required field.       |
        | Project Start Date  | Project Start Date is a required field. |
        | Project End Date    | Project End Date is a required field.   |

    Scenario:


    Scenario: Attempt to validate a proposal without a principal investigator
      When    I validate my proposal
      Then    I see an error that says There is no Principal Investigator selected. Please enter a Principal Investigator.
