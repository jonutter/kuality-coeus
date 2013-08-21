#TODO: Consider a way to handle the element definitions for questionnaire questions depending on the number of questionnaires present

class PHSFellowshipQuestionnaire < ProposalDevelopmentDocument

  proposal_header_elements

  RADIO_NAMES = [:indefinite_human_subjects, :clinical_trial, :phase_3_trial, :indefinite_vertebrates,
                 :human_stem_cells, :specific_cell_line, :seeking_degree_during_proposed_award,
                 :have_kirchstein_support, :have_kirschstein_support_start_date, :have_kirschstein_support_end_date,
                 :have_nih_grant_number, :have_additonal_kirschstein_support, :previous_submission,
                 :senior_fellowship_application, :supplement_funding]
  [0,1,2,3,
   4,5,27,
   37,40,42,
   44,46,73,
   75,79
  ].each_with_index do |num, index|
    action("#{RADIO_NAMES[index]}_element".to_sym) { |answer, b| b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[1].answers[#{num}].answer", value: answer) }
    action(RADIO_NAMES[index]) { |answer, b| b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[1].answers[#{num}].answer", value: answer).set }
  end

  # Stem cells...
  1.upto(20) do |x|
    element("phs_stem_cell_line_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[1].answers[#{5+x}].answer") }
  end

  SELECT_LIST_NAMES = [:field_of_training, :type_of_degree_during_proposed_award, :kirschstein_support_level, :kirschstein_support_recipient,
                           :salary_period]
  [26,30,38,39,
   77
  ].each_with_index do |num, index|
    element(SELECT_LIST_NAMES[index]) { |b| b.frm.select(name: "s2sQuestionnaireHelper.answerHeaders[1].answers[#{num}].answer") }
  end

  TEXT_FIELD_NAMES = [:expected_degree_completion_date, :kirschstein_support_start_date, :kirschstein_support_end_date, :nih_grant_number,
                          :former_institution, :present_institutional_base_salary, :salary_receipt_period, :supplemental_funding_amount,
                          :supplemental_funding_receipt_period, :supplemental_funding_type, :supplemental_funding_source]
  [29,41,43,45,
   74,76,78,80,
   81,82,83
  ].each_with_index do |num, index|
    element(TEXT_FIELD_NAMES[index]) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[1].answers[#{num}].answer") }
  end
end