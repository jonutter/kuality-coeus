Feature: Proposal Actions Validations

  As a researcher I want to know if my proposal contains any errors
  so that I can fix them prior to submitting my proposal

  Background: KC user is logged in as admin
      Given   I'm logged in with admin

    # TODO: This scenario description is too vague. "Validate" what? How?...
    # Suggested revision: The system disallows submitting Proposals without a Principal Investigator
    # (Note that if we go with the above description, however, we may want to add a check that the "submit" button doesn't exist)
    Scenario: Validate a proposal without a principal investigator
      Given I initiate a proposal
      And   the proposal has no principal investigator
      When  I activate a validation check
      Then  a validation error should say there is no principal investigator
      And   checking the key personnel page shows an error that says there is no principal investigator

    # TODO: This scenario description is too vague. "Validate" what? How?...
    Scenario: Validate a proposal with no proposal questions answered
      Given I initiate a proposal
      And   I do not answer my proposal questions
      When  I activate a validation check
      Then  a validation error should say proposal questions were not answered
      And   checking the questions page shows an error that says proposal questions were not answered

    # TODO: This scenario description is too vague. "Validate" what? How?...
    Scenario: Validate a proposal without a sponsor deadline date
      Given I initiate a proposal without a sponsor deadline date
      When  I activate a validation check
      Then  a validation error should say sponsor deadline date not entered
      And   checking the proposal page shows an error that says sponsor deadline date not entered

    # TODO: This scenario description is too vague. "Validate" what? How?...
    Scenario: Validate proposal with an un-certified co-investigator
      Given I initiate a proposal with an un-certified Co-Investigator
      When  I activate a validation check
      Then  a validation error should say the investigator needs to be certified
      And   checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified

    # TODO: This scenario description is too vague. "Validate" what? How?...
    Scenario: Validate a proposal with an un-certified principal investigator
      Given I initiate a proposal with an un-certified Principal Investigator
      When  I activate a validation check
      Then  a validation error should say the principal needs to be certified
      And   checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified

    # TODO: This scenario description is too vague. "Validate" what? How?...
    Scenario: Validate a proposal with an un-certified key person
      Given I initiate a proposal where the un-certified key person has certification questions
      When  I activate a validation check
      Then  a validation error should say the key person needs to be certified
      And   checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified

