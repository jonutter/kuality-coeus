class PHSFellowshipQuestions < ProposalDevelopmentDocument

  proposal_header_elements

  RADIO_NAMES = [:indefinite_human_subjects, :clinical_trial, :phase_3_trial, :indefinite_vertebrates,
                    :human_stem_cells, :specific_cell_line, :seeking_degree_during_proposed_award,
                    :kirchstein_nrsa_support, :support_period_start, :support_period_end, :nih_grant_number,
                    :prior_support_award, :prior_support_start, :prior_support_end, :have_prior_nih_grant_number,
                    :previous_submission, :senior_fellowship_application, :supplement_funding]
  [0,1,2,3,
   4,5,27,
   37,40,42,44,
   46,49,51,53,
   73,75,79
  ].each_with_index do |num, index|
    action("#{RADIO_NAMES[index]}_element".to_sym) { |answer, b| b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer) }
    action(RADIO_NAMES[index]) { |answer, b| b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer).set }
  end

  # Stem cells...
  1.upto(20) do |x|
    element("phs_stem_cell_line_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{5+x}].answer") }
  end

  SELECT_LIST_NAMES = [:field_of_training, :type_of_degree, :support_level, :support_recipient,
                           :prior_support_award_level, :prior_support_award_recipient]
  [26,30,38,39,
   47,48
  ].each_with_index do |num, index|
    element(SELECT_LIST_NAMES[index]) { |b| b.frm.select(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer") }
  end

  TEXT_FIELD_NAMES = [:expected_degree_completion_date, :support_start_date, :support_end_date, :support_grant_number,
                          :prior_support_start_date, :prior_support_end_date, :prior_nih_grant_number, :former_institution,
                          :present_base_salary, :salary_period, :salary_receipt_period, :supplemental_funding_amount,
                          :supplemental_funding_receipt_period, :supplemental_funding_type, :supplemental_funding_source]
  [29,41,43,45,
   50,52,54,74,
   76,77,78,80,
   81,82,83
  ].each_with_index do |num, index|
    element(TEXT_FIELD_NAMES[index]) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer") }
  end

end