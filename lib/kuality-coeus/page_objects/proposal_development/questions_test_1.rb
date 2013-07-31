PHS398_TRAINING_NAMES = [:bp1_funds, :bp1_undergrad_trainees, :bp1_predoc_trainees, :bp1_postdoc_trainees,
                         :bp1_full_nondegree_postdocs, :bp1_short_nondegree_postdocs, :bp1_full_degree_postdocs, :bp1_short_degree_postdocs,
                         :bp1_other_trainees, :bp2_funds, :bp2_undergrad_trainees, :bp2_predoc_trainees, :bp2_postdoc_trainees,
                         :bp2_full_nondegree_postdocs, :bp2_short_nondegree_postdocs, :bp2_full_degree_postdocs, :bp2_short_degree_postdocs,
                         :bp2_other_trainees, :bp3_funds, :bp3_undergrad_trainees, :bp3_predoc_trainees, :bp3_postdoc_trainees,
                         :bp3_full_nondegree_postdocs, :bp3_short_nondegree_postdocs, :bp3_full_degree_postdocs, :bp3_short_degree_postdocs,
                         :bp3_other_trainees, :bp4_funds, :bp4_undergrad_trainees, :bp4_predoc_trainees, :bp4_postdoc_trainees,
                         :bp4_full_nondegree_postdocs, :bp4_short_nondegree_postdocs, :bp4_full_degree_postdocs, :bp4_short_degree_postdocs,
                         :bp4_other_trainees, :bp5_funds, :bp5_undergrad_trainees, :bp5_predoc_trainees, :bp5_postdoc_trainees,
                         :bp5_full_nondegree_postdocs, :bp5_short_nondegree_postdocs, :bp5_full_degree_postdocs, :bp5_short_degree_postdocs,
                         :bp5_other_trainees]


[0,1,8,13,
 14,23,32,41,
 50,55,56,63,68,
 69,78,87,96,
 105,110,111,118,123,
 124,133,142,151,
 160,165,166,173,178,
 179,188,197,206,
 215,220,221,228,233,
 234,243,252,261,
 270].each_with_index do |num, index|
  action("#{PHS398_TRAINING_NAMES[index]}_element".to_sym) { |answer, b| b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer) }
  action(PHS398_TRAINING_NAMES[index]) { |answer, b| b.frm.radio(name: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{num}].answer", value: answer).set }
end

# PHS398 Training Questions

# Budget Period 1
element(:bp1_full_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[2].answer') }
element(:bp1_short_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[5].answer') }
element(:bp1_full_term_single_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[9].answer') }
element(:bp1_short_term_single_degree_trainees_1) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[10].answer') }
element(:bp1_full_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[11].answer') }
element(:bp1_short_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[12].answer') }
element(:bp1_full_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[51].answer') }
element(:bp1_short_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[53].answer') }

# Budget Period 1: Stipend Levels For Postdocs
1.upto(8) do |x|
  element("bp1_full_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{14+x}].answer") }
end

1.upto(8) do |x|
  element("bp1_short_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{23+x}].answer") }
end

1.upto(8) do |x|
  element("bp1_full_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{32+x}].answer") }
end

1.upto(8) do |x|
  element("bp1_short_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{41+x}].answer") }
end

# Budget Period 2
element(:bp2_full_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[57].answer') }
element(:bp2_short_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[60].answer')}
element(:bp2_full_term_single_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[64].answer') }
element(:bp2_short_term_single_degree_trainees_1) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[65].answer') }
element(:bp2_full_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[66].answer') }
element(:bp2_short_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[67].answer') }
element(:bp2_full_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[106].answer') }
element(:bp2_short_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[108].answer') }

# Budget Period 2: Stipend Levels For Postdocs
1.upto(8) do |x|
  element("bp2_full_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{69+x}].answer") }
end

1.upto(8) do |x|
  element("bp2_short_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{78+x}].answer") }
end

1.upto(8) do |x|
  element("bp2_full_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{87+x}].answer") }
end

1.upto(8) do |x|
  element("bp2_short_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{96+x}].answer") }
end

# Budget Period 3
element(:bp3_full_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[112].answer') }
element(:bp3_short_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[115].answer')}
element(:bp3_full_term_single_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[119].answer') }
element(:bp3_short_term_single_degree_trainees_1) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[120].answer') }
element(:bp3_full_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[121].answer') }
element(:bp3_short_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[122].answer') }
element(:bp3_full_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[161].answer') }
element(:bp3_short_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[163].answer') }

# Budget Period 3: Stipend Levels For Postdocs
1.upto(8) do |x|
  element("bp3_full_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{124+x}].answer") }
end

1.upto(8) do |x|
  element("bp3_short_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{133+x}].answer") }
end

1.upto(8) do |x|
  element("bp3_full_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{142+x}].answer") }
end

1.upto(8) do |x|
  element("bp3_short_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{151+x}].answer") }
end

# Budget Period 4
element(:bp4_full_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[167].answer') }
element(:bp4_short_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[170].answer')}
element(:bp4_full_term_single_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[174].answer') }
element(:bp4_short_term_single_degree_trainees_1) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[175].answer') }
element(:bp4_full_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[176].answer') }
element(:bp4_short_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[177].answer') }
element(:bp4_full_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[216].answer') }
element(:bp4_short_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[218].answer') }

# Budget Period 4: Stipend Levels For Postdocs
1.upto(8) do |x|
  element("bp4_full_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{179+x}].answer") }
end

1.upto(8) do |x|
  element("bp4_short_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{188+x}].answer") }
end

1.upto(8) do |x|
  element("bp4_full_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{197+x}].answer") }
end

1.upto(8) do |x|
  element("bp4_short_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{206+x}].answer") }
end

# Budget Period 5
element(:bp5_full_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[222].answer') }
element(:bp5_short_term_undergrad_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[225].answer')}
element(:bp5_full_term_single_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[229].answer') }
element(:bp5_short_term_single_degree_trainees_1) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[230].answer') }
element(:bp5_full_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[231].answer') }
element(:bp5_short_term_dual_degree_trainees) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[232].answer') }
element(:bp5_full_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[271].answer') }
element(:bp5_short_term_others) { |b| b.frm.text_field(name: 's2sQuestionnaireHelper.answerHeaders[0].answers[273].answer') }

# Budget Period 5: Stipend Levels For Postdocs
1.upto(8) do |x|
  element("bp5_full_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{234+x}].answer") }
end

1.upto(8) do |x|
  element("bp5_short_term_nondegree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{243+x}].answer") }
end

1.upto(8) do |x|
  element("bp5_full_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{252+x}].answer") }
end

1.upto(8) do |x|
  element("bp5_short_term_degree_postdocs_#{x}".to_sym) { |b| b.frm.text_field(id: "s2sQuestionnaireHelper.answerHeaders[0].answers[#{261+x}].answer") }
end