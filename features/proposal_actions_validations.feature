Feature: Proposal Actions Validations

  The Proposal Actions page contains a feature with which users can validate
  their proposal prior to submitting it. The validations cover a range data
  necessary for Proposal submissions.

  Background: KC user is logged in as admin
      Given   I am logged in as admin

    Scenario: Attempt to validate a proposal without a principal investigator
      When    I begin a proposal
       And    I activate a validation check
#      Then    I should see a key personal information error

#  Scenario: Attempt to validate a proposal with an incomplete budget
#      And     I have started a proposal
#      When    I activate a validation check
#      Then    I should see a budget versions error
#
#  Scenario: Attempt to validate a proposal without an answer to Proposal Questions
#      And     I have started a proposal
#      When    I activate a validation check
#      Then    I should see a proposal questions error