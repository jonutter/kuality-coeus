Feature: Submitting Proposals via s2s to Grants.gov

  As a researcher, I want the ability to submit my completed proposals
  through to grants.gov

  Background: Logged in with a proposal creator; have other necessary user
    Given I'm logged in with kctestuser9
    And   I have a user that can be a PI for Grants.gov proposals
    And   I have a user with the user name quickstart

  Scenario: Can successfully submit a proposal with NSF as the sponsor
    Given I initiate a proposal with NSF as the sponsor
    And   I add the Grants.Gov opportunity id of PA-B2-R01 to the proposal
    And   I add the Grants.gov user as the proposal's PI
    And   I set valid credit splits for the proposal
    And   I add and mark complete all the required attachments for an NSF proposal
    And   I create, finalize, and mark complete a budget version for the proposal
    And   I complete the required custom fields on the proposal
    And   I answer the S2S questions
    And   I submit the proposal
    And   I log in with the quickstart user
    When  I submit the proposal to S2S
    Then  Submission details will be immediately available on the S2S tab
    And   within a couple of minutes the submission status will be updated
  @test
  Scenario: Can successfully submit a proposal with NIH as the sponsor
    Given I initiate a proposal with NIH as the sponsor
    And   I add the Grants.Gov opportunity id of RR-TEST-NIH-FORMS2 to the proposal
    And   I add the Grants.gov user as the proposal's PI
    And   I set valid credit splits for the proposal
    And   I add and mark complete all the required attachments for an NIH proposal
    And   I create, finalize, and mark complete a budget version for the proposal
    And   I complete the required custom fields on the proposal
    And   I answer the S2S questions
    And   I submit the proposal
    And   I log in with the quickstart user
    When  I submit the proposal to S2S
    Then  Submission details will be immediately available on the S2S tab
    And   within a couple of minutes the submission status will be updated