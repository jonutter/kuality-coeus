Feature: Creating proposals

  As a researcher I want to be able to create valid proposals, so that I can get funding for my research.

  Background: KC user is logged in as admin
      Given   I am logged in as the admin

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

    Scenario: Attempt to create a proposal with invalid sponsor code
      When    I begin a proposal with an invalid sponsor code
      Then    I should see an error that says valid sponsor code required

    Scenario: Valid Proposals can be submitted to routing
      When    I complete a valid proposal
      And     I submit the proposal
      Then    The proposal should immediately have a status of Approval Pending
      And     The proposal's 'actions taken' should include 'Completed'
      And     The proposal's 'pending actions' should include 'in action list approve' requested of ???
      And     The proposal's 'future action requests' should include 'pending approve' requested of ???