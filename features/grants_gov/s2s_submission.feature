Feature: Submitting Proposals via s2s to Grants.gov

  As a researcher, I want the ability to submit my completed proposals
  through to grants.gov

  Background: Logged in with a proposal creator; have other necessary user
    Given a user exists with the system role: 'Proposal Creator'
    And   a user exists that can be a PI for Grants.gov proposals
    And   an AOR user exists
    And   I log in with the Proposal Creator user

  Scenario: Submit a proposal to Grants.gov with NSF as the sponsor
    Given I initiate a proposal with NSF as the sponsor
    And   add the Grants.Gov opportunity id of PA-B2-R01 to the proposal
    And   add the Grants.gov user as the proposal's PI
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments for an NSF proposal
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  Submission details will be immediately available on the S2S tab
    And   within a couple of minutes the submission status will be updated

  Scenario: Submit a proposal to Grants.gov with NIH as the sponsor
    Given I initiate a proposal with NIH as the sponsor
    And   add the Grants.Gov opportunity id of RR-TEST-NIH-FORMS2 to the proposal
    And   add the Grants.gov user as the proposal's PI
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments for an NIH proposal
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  Submission details will be immediately available on the S2S tab
    And   within a couple of minutes the submission status will be updated
  @test
  Scenario: Initiate a proposal with PHS forms attached
    Given I initiate a proposal with NIH as the sponsor
    And   add the Grants.Gov opportunity id of PA-B2-ALL to the proposal
    When  I attach the PHS training and fellowship forms to the proposal
    Then  the PHS training and fellowship questionnaires should be appear in the proposal

  Scenario: Attach the PHS Fellowship and Training forms, and complete the questionnaires
    Given I initiate a proposal with NIH as the sponsor
    And   add the Grants.Gov opportunity id of PA-B2-ALL to the proposal
    When  I attach the PHS training and fellowship forms to the proposal
    And   complete their respective questionnaires
    Then  the questionnaire titles should indicate that the questionnaires have been completed