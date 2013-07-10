Feature: Proposal Actions Validations

  As a researcher I want to know if my development proposal contains any errors
  so that I can fix them prior to submitting my proposal

  Background: KC user is logged in as admin
      Given   I'm logged in with admin

    Scenario: A validation check should show an error if a PI has not been added to the proposal
      Given I initiate a proposal
      And   the proposal has no principal investigator
      When  I activate a validation check
      Then  a validation error should say there is no principal investigator
      And   checking the key personnel page shows an error that says there is no principal investigator

    Scenario: A validation check should show an error if the proposal questions have not each been answered
      Given I initiate a proposal
      And   I do not answer my proposal questions
      When  I activate a validation check
      Then  a validation error should say proposal questions were not answered
      And   checking the questions page shows an error that says proposal questions were not answered

    Scenario: A validation check should show an error if a sponsor deadline date is missing
      Given I initiate a proposal without a sponsor deadline date
      When  I activate a validation check
      Then  a validation error should say sponsor deadline date not entered
      And   checking the proposal page shows an error that says sponsor deadline date not entered

    Scenario: A validation check should show an error if a co-investigator is added but not certified
      Given I initiate a proposal with an un-certified Co-Investigator
      When  I activate a validation check
      Then  a validation error should say the investigator needs to be certified
      And   checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified

    Scenario: A validation check should show an error if a PI is added but not certified
      Given I initiate a proposal with an un-certified Principal Investigator
      When  I activate a validation check
      Then  a validation error should say the principal needs to be certified
      And   checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified

    Scenario: A validation check should show an error if a Key Person is added but not certified
      Given I initiate a proposal where the un-certified key person has certification questions
      When  I activate a validation check
      Then  a validation error should say the key person needs to be certified
      And   checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified

