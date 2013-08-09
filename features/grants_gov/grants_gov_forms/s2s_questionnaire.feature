Feature: S2S Questionnaire Population and Functionality

  ##Consider a rewrite
  As a Researcher, there are certain forms that I can attach to a proposal that will result in
  the population of additional Questionnaires. I want the ability to complete these questionnaires,
  and to manage each responses' effects on my proposal.

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
