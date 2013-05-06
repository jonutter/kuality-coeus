class ProposalActions < ProposalDevelopmentDocument

  proposal_header_elements
  tab_buttons

  # Data Validation

  element(:validation_button) { |b| b.frm.button(name: 'methodToCall.activate') }
  action(:show_data_validation) { |b| b.frm.button(id: 'tab-DataValidation-imageToggle').click; b.validation_button.wait_until_present }
  action(:turn_on_validation) { |b| b.validation_button.click; b.key_personnel_button.wait_until_present }

  element(:key_personnel_button) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabKeyPersonnelInformationValidationErrors') }
  action(:show_key_personnel_errors) { |b| b.key_personnel_button.click }
  element(:key_personnel_errors) { |b| b.frm.tbody(id: 'tab-KeyPersonnelInformationValidationErrors-div').tds(width: '94%') }
  action(:show_budget_versions_errors) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabBudgetVersionsValidationErrors').click }
  action(:show_proposal_questions_errors) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabAProposalQuestionsValidationErrors').click }
  element(:proposal_questions_errors) { |b| b.frm.tbody(id: 'tab-AProposalQuestionsValidationErrors-div').tds(width: '94%') }
  action(:show_kuali_u_errors) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabCKualiUniversityValidationErrors').click }
  element(:kuali_u_errors) { |b| b.frm.tbody(id: 'tab-CKualiUniversityValidationErrors-div').tds(width: '94%') }
  action(:show_questionnaire_errors) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabS2SFATFlatQuestionnaireValidationErrors').click }
  element(:questionnaire_errors) { |b| b.frm.tbody(id: 'tab-S2SFATFlatQuestionnaireValidationErrors-div').tds(width: '94%') }
  action(:show_compliance_errors) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabBComplianceValidationErrors').click }
  element(:compliance_errors) { |b| b.frm.tbody(id: 'tab-BComplianceValidationErrors-div').tds(width: '94%') }

  action(:show_sponsor_warnings) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabSponsorProgramInformationWarnings').click }
  element(:sponsor_warnings) { |b| b.frm.tbody(id: 'tab-SponsorProgramInformationWarnings-div').tds(width: '94%') }

  value(:warnings) { |b| b.frm.td(text: 'Warnings').parent.parent.td(class: 'datacell').text }
  value(:grants_gov_errors) { |b| b.frm.td(text: 'Grants.Gov Errors').parent.parent.td(class: 'datacell').text }
  value(:unit_business_rules_errors) { |b| b.frm.td(text: 'Unit Business Rules Errors').parent.parent.td(class: 'datacell').text }
  value(:unit_business_rules_warnings) { |b| b.frm.td(text: 'Unit Business Rules Warnings').parent.parent.td(class: 'datacell').text }

  # Proposal Hierarchy

  element(:link_child_proposal) { |b| b.frm.text_field(id: 'newHierarchyProposalNumber') }
  element(:link_budget_type) { |b| b.frm.select(id: 'newHierarchyBudgetTypeCode') }
  action(:link_to_hierarchy) { |b| b.frm.button(name: 'methodToCall.linkToHierarchy.anchorProposalHierarchy').click }

  # Ad Hoc Recipients

  element(:person_action_requested) { |b| b.frm.select(name: 'newAdHocRoutePerson.actionRequested') }
  element(:person) { |b| b.frm.text_field(name: 'newAdHocRoutePerson.id') }
  action(:add_person_request) { |b| b.frm.button(name: 'methodToCall.insertAdHocRoutePerson').click }

  element(:group_action_requested) { |b| b.frm.select(name: 'newAdHocRouteWorkgroup.actionRequested') }
  element(:namespace_code) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientNamespaceCode') }
  element(:name) { |b| b.frm.text_field(name: 'newAdHocRouteWorkgroup.recipientName') }
  action(:add_group_request) { |b| b.frm.button(name: 'methodToCall.insertAdHocRouteWorkgroup').click }

  action(:delete_proposal) { |b| b.frm.button(name: 'methodToCall.deleteProposal').click }

  # Route Log



  def validation_errors_and_warnings
    errs = []
      validation_err_war_fields.each { |field| errs << field.html[/(?<=>).*(?=<)/] }
    errs
  end

  # =======
  private
  # =======

  element(:validation_err_war_fields) { |b| b.frm.tds(width: '94%') }

  #Action buttons
  element(:save_button) { |b| b.frm.button(name: 'methodToCall.save') }
  action(:save) { |b| b.save_button.click }

end