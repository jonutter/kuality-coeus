Feature: Appropriate forms per sponsor opportunity

  As a researcher, I want the ability to select various grants.gov and research.gov
  opportunities, and also to select the forms I wish to attach to my proposal development document


  Background: Logged in with a proposal creator
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
  @test
  Scenario Outline: Selecting the Opportunity ID: RR-FORMFAMILY-004-2010
    Given I initiate a proposal with NIH as the sponsor
    When  I add the Grants.Gov opportunity id of RR-FORMFAMILY-004-2010 to the proposal
    Then  the following s2s form attachment options should be present: <form name>

    Examples:
     | form name |
     | RR_SF424_1_2-V1.2                              |
     | FaithBased_SurveyOnEEO-v1.2                    |
     | NASA_OtherProjectInformation-V1.0              |
     | NASA_PIandOARSSupplementalDataSheet-V1.0       |
     | NASA_SeniorKeyPersonSupplementalDataSheet-V1.0 |
     | HHS_CheckList_2_1-V2.1                         |