Feature: S2S Questionnaire Population and Functionality

  Background: Logged in with a proposal creator; have other necessary user
    Given a user exists with the system role: 'Proposal Creator'
    And   a user exists that can be a PI for Grants.gov proposals
    And   an AOR user exists
    And   I log in with the Proposal Creator user

  Scenario: Initiate a proposal with PHS forms attached
  Given I initiate a proposal with NIH as the sponsor
  And   add the Grants.Gov opportunity id of PA-B2-ALL to the proposal
  When  I attach the PHS training and fellowship forms to the proposal
  Then  the PHS training and fellowship questionnaires should appear in the proposal

  Scenario: Attach the PHS Fellowship and Training forms, and complete the questionnaires
  Given I initiate a proposal with NIH as the sponsor
  And   add the Grants.Gov opportunity id of PA-B2-ALL to the proposal
  When  I attach the PHS training and fellowship forms to the proposal
  And   complete their respective questionnaires
  Then  the questionnaire titles should indicate that the questionnaires have been completed
