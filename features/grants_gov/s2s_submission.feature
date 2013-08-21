Feature: Submitting Proposals via s2s to Grants.gov

  As a researcher, I want the ability to submit my completed proposals
  through to grants.gov

  Background: Logged in with a proposal creator; have other necessary user
    Given a user exists with the system role: 'Proposal Creator'
    And   a user exists that can be a PI for Grants.gov proposals
    And   an AOR user exists
    And   I log in with the Proposal Creator user
  @test
  Scenario: Submit the NIH opportunity ID: RR-TEST-NIH-FORMS2 to Grants.gov
    Given I initiate a proposal with NIH as the sponsor
    And   add the Grants.Gov opportunity id of RR-TEST-NIH-FORMS2 to the proposal
    And   add the s2s forms provided by RR-TEST-NIH-FORMS2
    And   add the Grants.Gov user as the proposal's PI
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  the S2S tab's submission details will say the proposal is submitted
    And   within a couple minutes the submission status will be updated
  @test
  Scenario: Submit the NIH opportunity ID: RR-FORMFAMILY-009-2010 to Grants.gov
    Given I initiate a proposal with NIH as the sponsor
    And   add the Grants.Gov opportunity id of RR-FORMFAMILY-009-2010 to the proposal
    And   add the s2s forms provided by RR-FORMFAMILY-009-2010
    And   add the Grants.Gov user as the proposal's PI
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  the S2S tab's submission details will say the proposal is submitted
    And   within a couple minutes the submission status will be updated

  Scenario: Submit the DOD-Agency opportunity ID: CAL-TEST-DOD2 to Grants.gov
    Given I initiate a proposal with DOD-Agency as the sponsor
    And   add the Grants.Gov opportunity id of CAL-TEST-DOD2 to the proposal
    And   add the s2s forms provided by CAL-TEST-DOD2
    And   add the Grants.Gov user as the proposal's PI
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  the S2S tab's submission details will say the proposal is submitted
    And   within a couple minutes the submission status will be updated

  Scenario: Submit the DOD-Agency opportunity: CAL-FDP-JAD to Grants.gov
    Given I initiate a proposal with DOD-Agency as the sponsor
    And   add the Grants.Gov opportunity id of CAL-FDP-JAD to the proposal
    And   add the s2s forms provided by CAL-FDP-JAD
    And   add the Grants.Gov user as the proposal's PI
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  the S2S tab's submission details will say the proposal is submitted
    And   within a couple minutes the submission status will be updated

  # Blocked: Requires SubAward budget. See:
  Scenario: Submit the DOD-Agency opportunity: CSS-120809-SF424RR-V12 to Grants.gov
    Given I initiate a proposal with DOD-Agency as the sponsor
    And   add the Grants.Gov opportunity id of CSS-120809-SF424RR-V12 to the proposal
    And   add the s2s forms provided by CSS-120809-SF424RR-V12
    And   add the Grants.Gov user as the proposal's PI
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  the S2S tab's submission details will say the proposal is submitted
    And   within a couple minutes the submission status will be updated
  @test
  Scenario: Submit the NASA opportunity: RR-FORMFAMILY-004-2010 to Grants.gov
    Given I initiate a proposal with NASA - Washington as the sponsor
    And   add the Grants.Gov opportunity id of RR-FORMFAMILY-004-2010 to the proposal
    And   add the s2s forms provided by RR-FORMFAMILY-004-2010
    And   add the Grants.Gov user as the proposal's PI
    And   add a co-investigator
    And   set valid credit splits for the proposal
    And   add and mark complete all the required attachments
    And   create, finalize, and mark complete a budget version for the proposal
    And   complete the required custom fields on the proposal
    And   answer the S2S questions
    And   submit the proposal
    And   log in with the AOR user
    When  I submit the proposal to S2S
    Then  the S2S tab's submission details will say the proposal is submitted
    And   within a couple minutes the submission status will be updated

