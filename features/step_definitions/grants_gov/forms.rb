Then(/^the s2s form attachment options should be appropriate to the opportunity$/) do
  forms = {
      'RR-FORMFAMILY-004-2010' =>
          %w{RR_SF424_1_2-V1.2
             FaithBased_SurveyOnEEO-V1.2
             NASA_OtherProjectInformation-V1.0
             Nasa_PIandAORSupplementalDataSheet-V1.0
             NASA_SeniorKeyPersonSupplementalDataSheet-V1.0
             HHS_CheckList_2_1-V2.1},
      'RR-FORMFAMILY-009-2010' =>
          %w{RR_KeyPersonExpanded_1_2-V1.2
             RR_OtherProjectInfo_1_3-V1.3},
      'CSS-120809-SF424RR-V12' =>
          %w{RR_Budget-V1.1
             RR_Budget10-V1.1
             RR_SubawardBudget-V1.2
             RR_SubawardBudget30-V1.2
             RR_SubawardBudget10_10-V1.2
             RR_SubawardBudget10_30-V1.2
             RR_FedNonFedBudget-V1.1
             RR_FedNonFedBudget10-V1.1
             RR_FedNonFed_SubawardBudget-V1.2
             RR_FedNonFedSubawardBudget10_10-V1.2
             RR_FedNonFed_SubawardBudget30-V1.2
             RR_FedNonFed_SubawardBudget10_30-V1.2},
      'SK07132010SCR9020-2' =>
          %w{PHS_Fellowship_Supplemental_1_2-V1.2},
      'PA-B1-K08' =>
          %w{PHS398_CareerDevelopmentAwardSup_1_2-V1.2}
  }
  on S2S do |page|
    forms[@proposal.opportunity_id].each { |form_name| page.form_names.should include form_name }
  end
end