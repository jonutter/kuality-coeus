Feature: Proposal Actions Validations

  As a researcher I want to know if my development proposal contains any errors
  so that I can fix them prior to submitting my proposal

  Background: Logged in with a proposal creator user
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user

    Scenario: A PI has not been added to the proposal
      Given I initiate a proposal
      And   the proposal has no principal investigator
      When  I activate a validation check
      Then  a validation error should say there is no principal investigator
      And   checking the key personnel page shows an error that says there is no principal investigator

    Scenario: Sponsor deadline date is missing
      Given I initiate a proposal without a sponsor deadline date
      When  I activate a validation check
      Then  a validation error should say sponsor deadline date not entered
      And   checking the proposal page shows an error that says sponsor deadline date not entered

    Scenario Outline: A key person is added but not certified
      Given I initiate a proposal with an un-certified <Person>
      When  I activate a validation check
      Then  one of the errors should say the investigators aren't all certified
      And   checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified

    Examples:
      | Person                                  |
      | Co-Investigator                         |
      | Principal Investigator                  |

    Scenario: A Key Person is added but not certified
      Given I initiate a proposal where the un-certified key person has included certification questions
      When  I activate a validation check
      Then  one of the errors should say the investigators aren't all certified
      And   checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified
