Feature: Opportunity Code and S2S Form Mapping

  As a researcher, I want the ability to select various grants.gov and research.gov
  opportunities. These opportunities will each have unique forms that I can then choose to
  attach to my proposal document.

  ##Note: This mapping of opportunity codes to expected forms was inspired by a mapping chart provided to
  ##rSmart QA by Pat Slabach. Further investigation is necessary to ensure mapping accuracy.

  Background: Logged in with a proposal creator
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   initiate a proposal with NIH as the sponsor
  @test
  Scenario Outline: Selecting opportunities brings different forms
    Given I initiate a proposal with NIH as the sponsor
    When  I add the Grants.Gov opportunity id of <Opportunity> to the proposal
    Then  the s2s form attachment options should be appropriate to the opportunity

    Examples:
     | Opportunity             |
     | RR-FORMFAMILY-004-2010  |
     | RR-FORMFAMILY-009-2010  |
     | CSS-120809-SF424RR-V12  |
     | SK07132010SCR9020-2     |
     | PA-B1-K08               |
