Feature: Opportunity Code and S2S Form Mapping

  As a researcher, I want the ability to select various grants.gov and research.gov
  opportunities. These opportunities will each have unique forms that I can then choose to
  attach to my proposal document.

  ##Note: This mapping of opportunity codes to expected forms was inspired by a mapping chart provided to
  ##rSmart QA by Pat Slabach. Further investigation is necessary to ensure mapping efficiency.

  Background: Logged in with a proposal creator
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user

  Scenario Outline: Selecting the Opportunity ID: RR-FORMFAMILY-004-2010
    Given I initiate a proposal with NIH as the sponsor
    When  I add the Grants.Gov opportunity id of RR-FORMFAMILY-004-2010 to the proposal
    Then  the following s2s form attachment options should be present: <form name>

    Examples:
     | form name |
     | RR_SF424_1_2-V1.2                              |
     | FaithBased_SurveyOnEEO-V1.2                    |
     | NASA_OtherProjectInformation-V1.0              |
     | Nasa_PIandAORSupplementalDataSheet-V1.0        |
     | NASA_SeniorKeyPersonSupplementalDataSheet-V1.0 |
     | HHS_CheckList_2_1-V2.1                         |

  Scenario Outline: Selecting the Opporunity Id: RR-FORMFAMILY-009-2010
    Given I initiate a proposal with NIH as the sponsor
    When  I add the Grants.Gov opportunity id of RR-FORMFAMILY-009-2010 to the proposal
    Then  the following s2s form attachment options should be present: <form name>

    Examples:
    | form name                     |
    | RR_KeyPersonExpanded_1_2-V1.2 |
    | RR_OtherProjectInfo_1_3-V1.3  |

  Scenario Outline: Selecting the Opportunity ID: CSS-120809-SF424RR-V12
    Given I initiate a proposal with NIH as the sponsor
    When  I add the Grants.Gov opportunity id of CSS-120809-SF424RR-V12 to the proposal
    Then  the following s2s form attachment options should be present: <form name>

  Examples:
    | form name                             |
    | RR_Budget-V1.1                        |
    | RR_Budget10-V1.1                      |
    | RR_SubawardBudget-V1.2                |
    | RR_SubawardBudget30-V1.2              |
    | RR_SubawardBudget10_10-V1.2           |
    | RR_SubawardBudget10_30-V1.2           |
    | RR_FedNonFedBudget-V1.1               |
    | RR_FedNonFedBudget10-V1.1             |
    | RR_FedNonFed_SubawardBudget-V1.2      |
    | RR_FedNonFedSubawardBudget10_10-V1.2  |
    | RR_FedNonFed_SubawardBudget30-V1.2    |
    | RR_FedNonFed_SubawardBudget10_30-V1.2 |
  @test
  Scenario Outline: Selecting the Opportunity ID: SK07132010SCR9020-2
    Given I initiate a proposal with NIH as the sponsor
    When  I add the Grants.Gov opportunity id of SK07132010SCR9020-2 to the proposal
    Then  the following s2s form attachment options should be present: <form name>

  Examples:
    | form name                            |
    | PHS_Fellowship_Supplemental_1_2-V1.2 |

  Scenario Outline: Selecting the Opportunity ID: PA-B1-K08
    Given I initiate a proposal with NIH as the sponsor
    When  I add the Grants.Gov opportunity id of PA-B1-K08 to the proposal
    Then  the following s2s form attachment options should be present: <form name>

  Examples:
    | form name                                 |
    | PHS398_CareerDevelopmentAwardSup_1_2-V1.2 |

  Scenario Outline: Selecting the Opportunity ID: PA-B1-K08
    Given I initiate a proposal with NIH as the sponsor
    When  I add the Grants.Gov opportunity id of PA-B1-K08 to the proposal
    Then  the following s2s form attachment options should be present: <form name>

  Examples:
    | form name                                 |
    | PHS398_CareerDevelopmentAwardSup_1_2-V1.2 |