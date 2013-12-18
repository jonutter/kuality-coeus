Feature: Submitting Proposals via s2s to Grants.gov

  As a researcher, I want the ability to submit my completed proposals
  through to grants.gov

  Background: Logged in with a proposal creator; have other necessary user
    Given a User exists with the role: 'Proposal Creator'
    And   a User exists that can be a PI for Grants.gov proposals
    And   an AOR User exists
    And   I log in with the Proposal Creator user

  Scenario Outline: Submit a proposal to Grants.gov with various sponsors and opportunities
    Given I create a Proposal with <Sponsor> as the sponsor
    And   add the <Provider> opportunity id of <Opportunity> to the Proposal
    And   add the <Provider> user as the Proposal's PI
    And   set valid credit splits for the Proposal
    And   add and mark complete all the required attachments
    And   create a final and complete Budget Version for the Proposal
    And   complete the required custom fields on the Proposal
    And   answer the S2S questions
    And   submit the Proposal
    When  I log in with the AOR user
    And   submit the Proposal to S2S
    Then  the S2S tab's submission details will say the Proposal is submitted
    And   within a couple minutes the submission status will be updated

  Examples:
    | Provider   | Sponsor           | Opportunity              |
    | Grants.Gov | NIH               | RR-TEST-NIH-FORMS2       |
    | Grants.Gov | NIH               | RR-FORMFAMILY-009-2010   |
    | Grants.Gov | DOD-Agency        | CAL-TEST-DOD2            |
    | Grants.Gov | DOD-Agency        | CSS-120809-SF424RR-V12   |
    | Grants.Gov | NASA - Washington | RR-FORMFAMILY-004-2010   |