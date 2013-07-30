  #  PHS_FELLOWSHIP_NAMES = [:indefinite_human_subjects, :clinical_trial, :phase_3_trial, :indefinite_vertebrates,
  #                          :human_stem_cells, :specific_cell_line, :seeking_degree_during_proposed_award,
  #                          :kirchstein_nrsa_support, :support_period_start, :support_period_end, :nih_grant_number,
  #                          :prior_support_award, :prior_support_start, :prior_support_end, :prior_nih_grant_number,
  #                          :previous_submission, :senior_fellowship_application, :supplement_funding]
  #
  #
  #[0,1,2,3,
  # 4,5,27,
  # 37,40,42,44,
  # 46,49,51,53,
  # 73,75,79,].each_with_index do |num, index|
  #  action("#{PHS_FELLOWSHIP_NAMES[index]}_element".to_sym) { |answer, b| b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer) }
  #  action(PHS_FELLOWSHIP_NAMES[index]) { |answer, b| b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer).set }
  #end
  #
  ## Stem cells...
  #1.upto(20) do |x|
  #  element("phs_stem_cell_line_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[1].answers[#{5+x}].answer") }
  #end
  #
  #element(:field_of_training) { |b| b.frm.select(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[26].answer') }
  #element(:expected_degree_completion_date) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[29].answer') }
  #element(:type_of_degree) { |b| b.frm.select(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[30].answer') }
  #element(:support_level) { |b| b.frm.select(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[38].answer') }
  #element(:support_recipient) { |b| b.frm.select(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[39].answer') }
  #element(:support_start_date) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[41].answer') }
  #element(:support_end_date) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[43].answer') }
  #element(:support_grant_number) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[45].answer') }
  #element(:prior_support_award_level) { |b| b.frm.select(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[47].answer') }
  #element(:prior_support_award_recipient) { |b| b.frm.select(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[48].answer') }
  #element(:prior_support_end_date) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[50].answer') }
  #element(:prior_support_end_date) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[52].answer') }
  #element(:prior_nih_grant_number) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[54].answer') }
  #element(:former_institution) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[74].answer') }
  #element(:present_base_salary) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[76].answer') }
  #element(:salary_period) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[77].answer') }
  #element(:salary_receipt_period) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[78].answer') }
  #element(:supplemental_funding_amount) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[80].answer') }
  #element(:supplemental_funding_receipt_period) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[81].answer') }
  #element(:supplemental_funding_type) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[82].answer') }
  #element(:supplemental_funding_source) { |b| b.frm.text_field(id: 's2sQuestionnaireHelper.answerHeaders[0].answers[83].answer') }