class Questions < ProposalDevelopmentDocument

  proposal_header_elements
  error_messages

  # Used strictly for navigation validation...
  element(:questions_header) { |b| b.frm.h2(text: 'A. Proposal Questions') }

  # S2S Questions...
  action(:show_s2s_questions) { |b| b.frm.button(name: 'methodToCall.toggleTab.tab0').click }

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
  [0,1,4,7,10,13,16,19,21,28,31,32,34,36,37,38,39,40,41,42,43,64,65,66,68,70,72,75,77,80,81].each_with_index do |num, index|
    action("s2s_r#{index+1}"
           .to_sym) { |answer, b|
                                  b
                                  .q_num_div(
                                      num.to_s)
                                  .radio(value: answer)
                                  .set
    }
  end
  alias_method :civil_service, :s2s_r1
  alias_method :total_ftes, :s2s_r2

  1.upto(6) do |i|
    alias_method "year_#{i+1}".to_sym, "s2s_r#{i+2}".to_sym unless i==6
    element("fiscal_year_#{i}".to_sym) { |b| b.frm.select(name: "questionnaireHelper.answerHeaders[0].answers[#{i+(2*i-1)}].answer") }
    element("ftes_for_fy_#{i}".to_sym) { |b| b.frm.text_field(id: "questionnaireHelper.answerHeaders[0].answers[#{3*i}].answer") }
  end

  alias_method :potential_effects, :s2s_r8
  element(:explain_potential_effects) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[20].answer') }

  alias_method :international_support, :s2s_r9

  1.upto(5) do |n|
    element("support_provided_#{n}".to_sym) { |b| b.frm.select(name: "questionnaireHelper.answerHeaders[0].answers[#{21+n}].answer") }
  end

  element(:explain_support) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[27].answer') }

  alias_method :pi_in_govt, :s2s_r10
  element(:pis_us_govt_agency) { |b| b.frm.select(name: 'questionnaireHelper.answerHeaders[0].answers[29].answer') }
  element(:total_amount_requested) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[30].answer') }

  alias_method :pi_foreign_employee, :s2s_r11

  alias_method :change_in_pi, :s2s_r12
  element(:former_pi) { |b| b.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[33].answer') }

  alias_method :change_in_institution, :s2s_r13
  element(:former_institution) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[35].answer') }

  alias_method :renewal_application, :s2s_r14
  alias_method :inventions_conceived, :s2s_r15
  alias_method :previously_reported, :s2s_r16
  alias_method :disclose_title, :s2s_r17
  alias_method :clinical_trial, :s2s_r18
  alias_method :phase_3_trial, :s2s_r19
  alias_method :human_stem_cells, :s2s_r20
  alias_method :specific_cell_line, :s2s_r21
  alias_method :pi_new_investigator, :s2s_r22
  alias_method :proprietary_info, :s2s_r23

  # Stem cells...
  1.upto(20) do |x|
    element("stem_cell_line_#{x}".to_sym) { |b| b.frm.text_field(id: "questionnaireHelper.answerHeaders[0].answers[#{43+x}].answer") }
  end

  alias_method :environmental_impact, :s2s_r24
  element(:explain_environmental_impact) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[67].answer') }
  alias_method :authorized_exemption, :s2s_r25
  element(:explain_exemption) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[69].answer') }

  alias_method :site_historic, :s2s_r26
  element(:explain_historic_designation) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[71].answer') }

  alias_method :international_activities, :s2s_r27
  element(:identify_countries) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[73].answer') }
  element(:explain_international_activities) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[74].answer') }

  alias_method :other_agencies, :s2s_r28
  element(:submitted_to_govt_agency) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[76].answer') }
  element(:application_date) { |b| b.frm.text_field(id: 'questionnaireHelper.answerHeaders[0].answers[78].answer') }
  element(:program) { |b| b.frm.select(name: 'questionnaireHelper.answerHeaders[0].answers[79].answer') }
  
  alias_method :subject_to_review, :s2s_r29
  alias_method :novice_applicants, :s2s_r31

  # Proposal Questions...
  action(:show_proposal_questions) { |b| b.frm.button(name: 'methodToCall.toggleTab.tabAProposalQuestions').click }

  action(:agree_to_nih_policy) { |answer, b| b.frm.radio(name: 'document.developmentProposalList[0].proposalYnq[2].answer', value: answer).set }
  element(:policy_review_date) { |b| b.frm.text_field(id: 'document.developmentProposalList[0].proposalYnq[2].reviewDate') }

  # Compliance...
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
  
  private

  # Used in other elements. Not needed outside this class
  action(:q_num_div) { |index, b| b.frm.div(id: "HD0-QN#{index}div").div(class: 'Qresponsediv') }

  #Action buttons
  element(:save_button) { |b| b.frm.button(name: 'methodToCall.save') }
  action(:save) { |b| b.save_button.click }

end