Feature: Proposal Actions Validations

  As a researcher I want to activate a validation check against my
  proposals to determine if they contain any errors or incomplete information.

  Background: KC user is logged in as admin
      Given   I am logged in as admin
    @test
    Scenario: Attempt to validate a proposal without a principal investigator
      When    I begin a proposal
      And     the proposal has no principal investigator
      And     I activate a validation check
      Then    the validation error should say there is no principal investigator
      And     checking the key personnel page shows an error that says there is no principal investigator

    Scenario: Attempt to validate a proposal without answering proposal questions
      When    I begin a proposal
      And     I do not answer my proposal questions
      And     I activate a validation check
      Then    the validation error should say proposal questions were not answered
      And     checking the key personnel page shows an error that says proposal questions were not answered

    Scenario: Attempt to validate a proposal without a sponsor deadline date
      When    I begin a proposal without a sponsor deadline date
      And     I activate a validation check
      Then    the validation error should say sponsor deadline date not entered
      And     checking the proposal page shows an error that says sponsor deadline date not entered

    Scenario: Attempt to validate proposal without completing the S2S FAT & Flat questionnaire
      When    I begin a proposal
      And     I do not complete the S2S FAT & Flat questionnaire
      And     I activate a validation check
      Then    the validation error should say questionnaire must be completed

    Scenario: Attempt to validate a proposal without completing the compliance question
      When    I begin a proposal
      And     I do not complete the compliance question
      And     I activate a validation check
      Then    the validation error should say you must complete the compliance question

    Scenario: Attempt to validate a proposal without completing the kuali university questions
      When    I begin a proposal
      And     I do not complete the kuali university questions
      And     I activate a validation check
      #TODO: create a flexible way to answer these questions
      Then    the validation error should say you must complete the kuali university questions

    Scenario: Attempt to validate proposal without certifying co-investigator
      When    I begin a proposal
      And     I add a co-investigator without certifying him
      And     I activate a validation check
      Then    the validation error should say the investigator needs to be certified