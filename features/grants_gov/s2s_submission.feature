#TODO: Fix problem with AOR user submitting to S2S
Feature: Submitting Proposals via s2s to Grants.gov

  As a researcher, I want the ability to submit my completed proposals
  through to grants.gov so that I can get funding for them
  @test
  Scenario Outline: Submit a proposal to Grants.gov with various sponsors and opportunities
    Given Users exist with the following roles: Proposal Creator, OSPApprover
    And   a User exists that can be a PI for Grants.gov proposals
    And   an AOR User exists
    And   the Proposal Creator creates a Proposal with <Sponsor> as the sponsor
    And   add the <Provider> opportunity id of <Opportunity> to the Proposal
    And   add the <Provider> user as the Proposal's PI
    And   the Proposal Creator completes the remaining required actions for an S2S submission
    And   I submits the Proposal into routing
    And   the OSPApprover approves the Proposal without future approval requests
    And   the principal investigator approves the Proposal
    When  the AOR user submits the Proposal to S2S
    Then  the S2S tab's submission details will say the Proposal is submitted
    And   within a couple minutes the submission status will be updated

  Examples:
    | Provider   | Sponsor           | Opportunity              |
    | Grants.Gov | NIH               | RR-TEST-NIH-FORMS2       |
    | Grants.Gov | NIH               | RR-FORMFAMILY-009-2010   |
    | Grants.Gov | DOD-Agency        | CAL-TEST-DOD2            |
    | Grants.Gov | DOD-Agency        | CSS-120809-SF424RR-V12   |
    | Grants.Gov | NASA - Washington | RR-FORMFAMILY-004-2010   |