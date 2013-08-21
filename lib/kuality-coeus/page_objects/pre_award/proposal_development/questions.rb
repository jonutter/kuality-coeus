class Questions < ProposalDevelopmentDocument

  S2S_RADIO_NAMES = [:civil_service, :total_ftes, :year_2, :year_3, :year_4, :year_5, :year_6, :potential_effects,
                     :international_support, :pi_in_govt, :pi_foreign_employee, :change_in_pi, :change_in_institution,
                     :renewal_application, :inventions_conceived, :previously_reported, :disclose_title,
                     :clinical_trial, :phase_3_trial, :human_stem_cells, :specific_cell_line, :pi_new_investigator,
                     :proprietary_info, :environmental_impact, :authorized_exemption, :site_historic,
                     :international_activities, :other_agencies, :subject_to_review, :novice_applicants]

  proposal_header_elements

  # Used strictly for navigation validation...
  element(:questions_header) { |b| b.frm.h2(text: 'A. Proposal Questions') }

  # S2S Radio button questions...
  # PLEASE NOTE: These radio buttons are a
  # deviation from the typical radio button element definitions.
  #
  # In general, you want to define a radio button as an ELEMENT, not an ACTION.
  #
  # However, because there are so many radio elements on this page, and they all
  # differ from each other in a very specific way, we are going to exploit this
  # here in the page class as well as in how the associated data object's
  # class instance variables get defined and used to update them.
  #
  # Use these radio buttons in your step definitions (or Object Class) like this example:
  # ...
  # page.civil_service "Y" #=> The "Y" is the value of the instance variable, and could also be "N"
  # ...
  [0,1,4,7,10,13,16,19,
   21,28,31,32,34,
   36,37,38,39,
   40,41,42,43,64,
   65,66,68,70,
   72,75,78,84
  ].each_with_index do |num, index|
    action("#{S2S_RADIO_NAMES[index]}_element".to_sym) { |answer, b| b.frm.radio(name: "questionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer) }
    action(S2S_RADIO_NAMES[index]) { |answer, b| b.frm.radio(name: "questionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer).set }
  end

  1.upto(6) do |i|
    element("fiscal_year_#{i}".to_sym) { |b| b.frm.select(name: "questionnaireHelper.answerHeaders[0].answers[#{i+(2*i-1)}].answer") }
    element("ftes_for_fy_#{i}".to_sym) { |b| b.frm.text_field(id: "questionnaireHelper.answerHeaders[0].answers[#{3*i}].answer") }
  end

  element(:explain_potential_effects) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[20].answer') }

  1.upto(5) do |n|
    element("support_provided_#{n}".to_sym) { |b| b.frm.select(name: "questionnaireHelper.answerHeaders[0].answers[#{21+n}].answer") }
  end

  element(:explain_support) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[27].answer') }
  element(:pis_us_govt_agency) { |b| b.frm.select(name: 'questionnaireHelper.answerHeaders[0].answers[29].answer') }
  element(:total_amount_requested) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[30].answer') }
  element(:former_pi) { |b| b.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[33].answer') }
  element(:former_institution) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[35].answer') }

  # Stem cells...
  1.upto(20) do |x|
    element("stem_cell_line_#{x}".to_sym) { |b| b.frm.text_field(id: "questionnaireHelper.answerHeaders[0].answers[#{43+x}].answer") }
  end

  element(:explain_environmental_impact) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[67].answer') }
  element(:explain_exemption) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[69].answer') }
  element(:explain_historic_designation) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[71].answer') }
  element(:identify_countries) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[73].answer') }
  element(:explain_international_activities) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[74].answer') }
  element(:submitted_to_govt_agency) { |b| b.frm.select(id: 'questionnaireHelper.answerHeaders[0].answers[76].answer') }
  element(:application_date) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[81].answer') }
  element(:program) { |b| b.frm.select(name: 'questionnaireHelper.answerHeaders[0].answers[82].answer') }

  # Proposal Questionnaire...
  action(:show_proposal_questions) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabAProposalQuestions').click }

  action(:agree_to_nih_policy) { |answer, b| b.frm.radio(name: 'document.developmentProposalList[0].proposalYnq[2].answer', value: answer).set }
  element(:policy_review_date) { |b| b.frm.text_field(id: 'document.developmentProposalList[0].proposalYnq[2].reviewDate') }

  # Compliance Questionnaire...
  action(:show_compliance_questions) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabBCompliance').click }

  action(:agree_to_ethical_conduct) { |answer, b| b.frm.radio(name: 'document.developmentProposalList[0].proposalYnq[1].answer', value: answer).set }
  element(:conduct_review_date) { |b| b.frm.text_field(name: 'document.developmentProposalList[0].proposalYnq[1].reviewDate') }

  # Kuali University

  # Note that this method gets the Watir li element objects and returns them
  # in a collection. You will have to specify which error li you want, plus the text
  # attribute for that li.
  #
  # For example, if you want the text of the second error listed, your code should look
  # like this:
  #
  # page.kuali_university_errors[1].text
  element(:kuali_university_errors) { |b| b.frm.div(id: 'tab-CKualiUniversity-div').div(class: 'error').lis }

  action(:show_kuali_university) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabCKualiUniversity').click }

  action(:dual_dept_appointment) { |answer, b| b.frm.radio(value: answer, name: 'document.developmentProposalList[0].proposalYnq[0].answer').set }
  element(:dual_dept_review_date) { |b| b.frm.text_field(name: 'document.developmentProposalList[0].proposalYnq[0].reviewDate') }
  element(:dual_dept_explanation) { |b| b.frm.text_field(name: 'document.developmentProposalList[0].proposalYnq[0].explanation') }

  action(:on_sabbatical) { |answer, b| b.frm.radio(value: answer, name: 'document.developmentProposalList[0].proposalYnq[3].answer').set }
  element(:sabbatical_review_date) { |b| b.frm.text_field(name: 'document.developmentProposalList[0].proposalYnq[3].reviewDate') }
  
  action(:used_by_small_biz) { |answer, b| b.frm.radio(value: answer, name: 'document.developmentProposalList[0].proposalYnq[4].answer').set }
  element(:small_biz_review_date) { |b| b.frm.text_field(name: 'document.developmentProposalList[0].proposalYnq[4].reviewDate') }

  action(:understand_deadline) { |answer, b| b.frm.radio(value: answer, name: 'document.developmentProposalList[0].proposalYnq[5].answer').set }
  element(:deadline_review_date) { |b| b.frm.text_field(name: 'document.developmentProposalList[0].proposalYnq[5].reviewDate') }

end