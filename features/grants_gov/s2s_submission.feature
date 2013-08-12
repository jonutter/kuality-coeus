Feature: Submitting Proposals via s2s to Grants.gov

  As a researcher, I want the ability to submit my completed proposals
  through to grants.gov

  Background: Logged in with a proposal creator; have other necessary user
    Given a user exists with the system role: 'Proposal Creator'
    And   a user exists that can be a PI for Grants.gov proposals
    And   an AOR user exists
    And   I log in with the Proposal Creator user

  Scenario Outline: Submit a proposal to Grants.gov with various sponsors and opportunities
    Given I initiate a proposal with <Sponsor> as the sponsor
    And   add the <Provider> opportunity id of <Opportunity> to the proposal
    And   add the <Provider> user as the proposal's PI
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments for an <Sponsor> proposal
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  Submission details will be immediately available on the S2S tab
    And   within a couple minutes the submission status will be updated

  Examples:
    | Provider   | Sponsor | Opportunity                  |
    | Grants.Gov | NSF     | RR-FORMFAMILY-004            |
    | Grants.Gov | NIH     | RR-TEST-NIH-FORMS2           |
    | Grants.Gov | NIH     | RR-TEST-NIH-FORMS2-With-CFDA |