Feature: S2S Questionnaire Population and Functionality

  Background: Logged in with a proposal creator; have other necessary user
    Given a User exists with the system role: 'Proposal Creator'
    And   a User exists that can be a PI for Grants.gov proposals
    And   an AOR User exists
    And   I log in with the Proposal Creator user

  Scenario: Initiate a proposal with PHS forms attached
  Given I initiate a Proposal with NIH as the sponsor
  And   add the Grants.Gov opportunity id of PA-B2-ALL to the Proposal
  When  I attach the PHS Training and Fellowship Forms to the Proposal
  Then  the PHS Training and Fellowship Questionnaires should appear in the Proposal

  Scenario: Attach the PHS Fellowship form and complete its questionnaire
  Given I initiate a Proposal with NIH as the sponsor
  And   add the Grants.Gov opportunity id of PA-B2-ALL to the Proposal
  When  I attach the PHS Fellowship Form to the Proposal
  And   complete its questionnaire
  Then  the questionnaire's title should indicate that the questionnaire has been completed
