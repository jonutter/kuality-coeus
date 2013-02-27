Feature: Proposal Actions Validations

  As a researcher I want to activate a validation check against my
  proposals to determine if they contain any errors or incomplete information.

  Background: KC user is logged in as admin
      Given   I am logged in as admin

    Scenario: Attempt to validate a proposal without a principal investigator
      When    I begin a proposal
      And     the proposal has no principal investigator
      And     I activate a validation check
      Then    the validation error should say there is no principal investigator

    Scenario: Attempt to validate a proposal without answering proposal questions
      When    I begin a proposal
      And     I do not answer my proposal questions
      And     I activate a validation check
      Then    the validation error should say proposal questions were not answered

    Scenario: Attempt to validate a proposal without a sponsor deadline date
      When    I begin a proposal without a sponsor deadline date
      And     I activate a validation check
      Then    the validation error should say sponsor deadline date not entered