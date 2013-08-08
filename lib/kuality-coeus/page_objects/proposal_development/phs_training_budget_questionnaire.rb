class PHS398TrainingBudgetQuestionnaire < ProposalDevelopmentDocument

  proposal_header_elements

  def self.phs_398_radio_names
    array = []
    1.upto(5) do |x|
      %w{funds
        undergrad_trainees
        predoc_trainees
        postdoc_trainees
        nondegree_postdocs
        short_nondegree_postdocs
        full_degree_postdocs
        short_degree_postdocs
        other_trainees}.each do |name|
        array << "bp#{x}_#{name}".to_sym
      end
    end
    array
  end

  [0,1,8,13,14,23,32,41,50,55,56,63,68,69,78,87,96,105,110,111,118,123,124,133,142,151,
   160,165,166,173,178,179,188,197,206,215,220,221,228,233,234,243,252,261,270].each_with_index do |num, index|
    action("#{phs_398_radio_names[index]}_element".to_sym) { |answer, b|
      b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer) }
    action(phs_398_radio_names[index]) { |answer, b|
      b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer).set }
  end

  0.upto(4) do |x|
    element("bp#{x+1}_full_term_undergrad_trainees".to_sym) { |b| b.frm.text_field(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{2+(x*55)}].answer") }
    element("bp#{x+1}_short_term_undergrad_trainees".to_sym) { |b| b.frm.text_field(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{5+(x*55)}].answer") }
    element("bp#{x+1}_full_term_single_degree_trainees".to_sym) { |b| b.frm.text_field(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{9+(x*55)}].answer") }
    element("bp#{x+1}_short_term_single_degree_trainees_1".to_sym) { |b| b.frm.text_field(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{10+(x*55)}].answer") }
    element("bp#{x+1}_full_term_dual_degree_trainees".to_sym) { |b| b.frm.text_field(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{11+(x*55)}].answer") }
    element("bp#{x+1}_short_term_dual_degree_trainees".to_sym) { |b| b.frm.text_field(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{12+(x*55)}].answer") }
    element("bp#{x+1}_full_term_others".to_sym) { |b| b.frm.text_field(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{51+(x*55)}].answer") }
    element("bp#{x+1}_short_term_others".to_sym) { |b| b.frm.text_field(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{53+(x*55)}].answer") }
    0.upto(7) do |n|
      element("bp#{x+1}_full_term_nondegree_postdocs_#{n}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{(15+n)+(x*55)}].answer") }
      element("bp#{x+1}_short_term_nondegree_postdocs_#{n}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{(24+n)+(x*55)}].answer") }
      element("bp#{x+1}_full_term_degree_postdocs_#{n}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{(33+n)+(x*55)}].answer") }
      element("bp#{x+1}_short_term_degree_postdocs_#{n}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{(42+n)+(x*55)}].answer") }
    end
  end

  # Questionnaire Title Tab

end