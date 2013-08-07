class PHSFellowshipQuestionnaireObject

  YN_QUESTIONS = [:indefinite_human_subjects, :clinical_trial, :phase_3_trial, :indefinite_vertebrates,
                  :human_stem_cells, :specific_cell_line, :seeking_degree_during_proposed_award,
                  :have_kirchstein_support, :have_kirschstein_support_start_date, :have_kirschstein_support_end_date,
                  :have_nih_grant_number, :have_additional_kirschstein_support, :previous_submission,
                  :senior_fellowship_application, :supplement_funding]
  include Foundry
  include DataFactory
  include StringFactory
  include Navigation
  include Utilities

  attr_accessor :indefinite_human_subjects, :clinical_trial, :phase_3_trial, :indefinite_vertebrates,
                :human_stem_cells, :specific_cell_line, :field_of_training, :seeking_degree_during_proposed_award,
                :expected_degree_completion_date, :type_of_degree_during_proposed_award, :have_kirchstein_support,
                :kirschstein_support_level, :kirschstein_support_recipient, :have_kirschstein_support_start_date,
                :kirschstein_support_start_date, :have_kirschstein_support_end_date, :kirschstein_support_end_date,
                :have_nih_grant_number, :nih_grant_number, :additional_kirschstein_support, :previous_submission,
                :former_institution, :senior_fellowship_application, :present_institutional_base_salary, :salary_period,
                :supplement_funding, :supplemental_funding_amount, :supplemental_funding_receipt_period, :supplemental_funding_type,
                :supplemental_funding_source
  # More instance variable definitions.
  # These make instance variables such as:
  # @stem_cell_line_1 (up to 20)
  1.upto(20) do |x|
    attr_accessor("stem_cell_line_#{x}".to_sym)
  end

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        indefinite_human_subjects:            'N',
        clinical_trial:                       'N',
        indefinite_vertebrates:               'N',
        human_stem_cells:                     'N',
        field_of_training:                    '1110 Biological Chemistry',
        seeking_degree_during_proposed_award: 'N',
        have_kirchstein_support:              'N',
        previous_submission:                  'N',
        senior_fellowship_application:        'N'
    }

    set_options(defaults.merge(opts))
    requires :document_id, :doc_type
  end

  def create
    navigate
    on(S2S).questions
    on(Questions).expand_all
    on PHSFellowshipQuestionnaire do |phs_fellowship|

    # Answers all of the Yes/No questions first (in random order)
    YN_QUESTIONS.shuffle.each do |q|
      var = get(q)
      phs_fellowship.send(q, var) if var != nil && phs_fellowship.send("#{q}_element".to_sym, var).present?
    end

    # Next we answer the questions that are conditional, based on the above answers...
    1.upto(20) do |n|
      scl = "phs_stem_cell_line_#{n}"
      phs_fellowship.send(scl).fit get(scl)
    end

    fill_out phs_fellowship, :expected_degree_completion_date,
             :kirschstein_support_start_date, :kirschstein_support_end_date, :nih_grant_number, :former_institution,
             :present_institutional_base_salary, :salary_receipt_period, :supplemental_funding_amount,
             :supplemental_funding_receipt_period, :supplemental_funding_type, :supplemental_funding_source

    phs_fellowship.save
    end

  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document @doc_type
    on(Proposal).questions unless on_page?(on(Questions).questions_header)
  end
end



