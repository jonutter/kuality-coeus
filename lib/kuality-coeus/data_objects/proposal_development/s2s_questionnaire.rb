class S2SQuestionnaireObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation
  include Utilities

  attr_accessor :document_id, :civil_service, :total_ftes, :potential_effects, :explain_potential_effects,
                :international_support, :explain_support, :pi_in_govt, :pis_us_govt_agency, :total_amount_requested,
                :pi_foreign_employee, :change_in_pi, :former_pi, :change_in_institution, :former_institution,
                :renewal_application, :inventions_conceived, :previously_reported, :disclose_title,
                :clinical_trial, :phase_3_trial, :human_stem_cells, :specific_cell_line,
                :pi_new_investigator, :proprietary_info, :environmental_impact, :explain_environmental_impact,
                :authorized_exemption, :explain_exemption, :site_historic, :explain_historic_designation,
                :international_activities, :identify_countries, :explain_international_activities,
                :other_agencies, :submitted_to_govt_agency, :application_date, :subject_to_review,
                :novice_applicants, :program
  # More instance variable definitions.
  # These make instance variables such as:
  # @year_2 (up to year 6)
  # @support_provided_1  (up to 5)
  # @fiscal_year_1 (up to 6)
  # @ftes_for_fy_1 (up to 6)
  # @stem_cell_line_1 (up to 20)
  1.upto(20) do |x|
    attr_accessor("year_#{x+1}".to_sym, "support_provided_#{x}".to_sym) if x < 6
    attr_accessor("fiscal_year_#{x}".to_sym, "ftes_for_fy_#{x}".to_sym) if x < 7
    attr_accessor("stem_cell_line_#{x}".to_sym)
  end

  def initialize(browser, opts={})
    @browser = browser

    # PLEASE NOTE:
    # This is a unique data object class in that
    # it breaks the typical model for radio button
    # methods and their associated class instance variables
    #
    # In general, it's not workable to set up radio button elements
    # to use "Y" and "N" as the instance variables associated with them.
    defaults = {
        civil_service:            'N',
        potential_effects:        'N',
        international_support:    'N',
        pi_in_govt:               'N',
        pi_foreign_employee:      'N',
        change_in_pi:             'N',
        change_in_institution:    'N',
        renewal_application:      'N',
        disclose_title:           'N',
        clinical_trial:           'N',
        human_stem_cells:         'N',
        pi_new_investigator:      'N',
        proprietary_info:         'N',
        environmental_impact:     'N',
        site_historic:            'N',
        international_activities: 'N',
        other_agencies:           'N',
        subject_to_review:        'N',
        program:                  'Program not covered by EO 12372',
        novice_applicants:        'X' # Note the X, here. That's for the "N/A" option.
    }

    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create
    navigate
    on Questions do |fat|
      fat.show_s2s_questions

      # Answers all of the Yes/No questions first (in random order)
      yn_questions.shuffle.each do |q|
        var = get(q)
        fat.send(q, var) unless var==nil
      end

      # Next we answer the questions that are conditional, based on the above answers...
      1.upto(6) do |n|
        fy = "fiscal_year_#{n}"
        fat.send(fy).pick!(get(fy))
        ftes = "ftes_for_fy_#{n}"
        fat.send(ftes).fit get(ftes)
        yr = "year_#{n+1}"
        var = get(yr)
        fat.send(yr, var) unless var==nil
      end
      #fat.explain_potential_effects.fit @explain_potential_effects
      1.upto(5) do |n|
        sp = "support_provided_#{n}"
        fat.send(sp).pick! get(sp)
      end
      #fat.explain_support.fit @explain_support
      #fat.pis_us_govt_agency.pick! @pis_us_govt_agency
      #fat.total_amount_requested.fit @total_amount_requested
      #fat.former_pi.fit @former_pi
      #fat.former_institution.fit @former_institution
      1.upto(20) do |n|
        scl = "stem_cell_line_#{n}"
        fat.send(scl).fit get(scl)
      end
      fill_out fat, :explain_potential_effects, :explain_support, :pis_us_govt_agency,
                    :total_amount_requested, :former_pi, :former_institution,
                    :explain_environmental_impact, :explain_exemption, :explain_historic_designation,
                    :identify_countries, :explain_international_activities, :submitted_to_govt_agency,
                    :application_date, :program
    end
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document unless on_document?
    on(Proposal).questions unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(Questions).questions_header.exist?
    rescue
      false
    end
  end

  # Convenient gathering of all Yes/No questions. Makes it possible to
  # do simple iterations through them.
  def yn_questions
    [:civil_service, :total_ftes, :potential_effects, :international_support,
     :pi_in_govt, :pi_foreign_employee, :change_in_pi, :change_in_institution,
     :renewal_application, :inventions_conceived, :previously_reported,
     :disclose_title, :clinical_trial, :phase_3_trial, :human_stem_cells,
     :specific_cell_line, :pi_new_investigator, :proprietary_info,
     :environmental_impact, :authorized_exemption, :site_historic,
     :international_activities, :other_agencies, :subject_to_review,
     :novice_applicants]
  end

end