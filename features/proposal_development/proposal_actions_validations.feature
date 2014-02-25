Feature: Proposal Actions Validations

  As a researcher I want to know if my development proposal contains any errors
  so that I can fix them prior to submitting my proposal

  Background: Logged in with a proposal creator user
    * a User exists with the role: 'Proposal Creator'
    * I log in with the Proposal Creator user

    Scenario: A PI has not been added to the proposal
      Given the Proposal Creator creates a Proposal
      And   the Proposal has no principal investigator
      When  I activate a validation check
      Then  an error should appear on the actions page that says there is no principal investigator

    Scenario: Sponsor deadline date is missing
      Given the Proposal Creator creates a Proposal without a sponsor deadline date
      When  I activate a validation check
      Then  an error should appear on the actions page that says sponsor deadline date not entered
    @test
    Scenario Outline: Investigators added but not certified
      Given I create a Proposal with an un-certified <Person>
      When  I activate a validation check
      Then  an error should appear on the actions page that says the key person is not certified

    Examples:
      | Person                  |
      | Co-Investigator         |
      | Principal Investigator  |

    Scenario: A Key Person is added but not certified
      Given I create a Proposal where the un-certified key person has included certification questions
      When  I activate a validation check
      Then  an error should appear on the actions page that says the key person is not certified
