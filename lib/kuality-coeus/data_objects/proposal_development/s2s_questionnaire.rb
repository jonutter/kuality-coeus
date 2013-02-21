class S2SQuestionnaireObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

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
        civil_service: 'N',
        potential_effects: 'N',
        international_support: 'N',
        pi_in_govt: 'N',
        pi_foreign_employee: 'N',
        change_in_pi: 'N',
        change_in_institution: 'N',
        renewal_application:'N',
        disclose_title: 'N',
        clinical_trial: 'N',
        human_stem_cells: 'N',
        pi_new_investigator: 'N',
        proprietary_info: 'N',
        environmental_impact: 'N',
        site_historic: 'N',
        international_activities:'N',
        other_agencies: 'N',
        subject_to_review:'N',
        program: 'Program not covered by EO 12372',
        novice_applicants: 'X' # Note the X, here. That's for the "N/A" option.
    }
    set_options(defaults.merge(opts))
    requires @document_id
  end

  def create
    navigate
    on Questions do |fat|
      fat.show_s2s_questions
      fat.civil_service @civil_service
      fat.total_ftes @total_ftes
      1.upto(6) do |n|
        fat.send("fiscal_year_#{n}".to_sym).pick eval("@fiscal_year_#{n}")
        fat.send("ftes_for_fy_#{n}".to_sym).fit eval("@ftes_for_fy_#{n}")
        fat.send("year_#{n+1}".to_sym, eval("@year_#{n+1}")) unless n==6
      end
      fat.potential_effects @potential_effects
      fat.explain_potential_effects.fit @explain_potential_effects
      fat.international_support @international_support
      1.upto(5) do |n|
        fat.send("support_provided_#{n}".to_sym).pick eval("@support_provided_#{n}")
      end
      fat.explain_support.fit @explain_support
      fat.pi_in_govt @pi_in_govt
      @pis_us_govt_agency=fat.pis_us_govt_agency.pick @pis_us_govt_agency
      fat.total_amount_requested.fit @total_amount_requested
      fat.pi_foreign_employee @pi_foreign_employee
      fat.change_in_pi @change_in_pi
      fat.former_pi.fit @former_pi
      fat.change_in_institution @change_in_institution
      fat.former_institution.fit @former_institution
      fat.renewal_application @renewal_application
      fat.inventions_conceived @inventions_conceived
      fat.previously_reported @previously_reported
      fat.disclose_title @disclose_title
      fat.clinical_trial @clinical_trial
      fat.phase_3_trial @phase_3_trial
      fat.human_stem_cells @human_stem_cells
      fat.specific_cell_line @specific_cell_line
      1.upto(20) do |n|
        fat.send("stem_cell_line_#{n}".to_sym).fit eval("@stem_cell_line_#{n}")
      end
      fat.pi_new_investigator @pi_new_investigator
      fat.proprietary_info @proprietary_info
      fat.environmental_impact @environmental_impact
      fat.explain_environmental_impact.fit @explain_environmental_impact
      fat.authorized_exemption @authorized_exemption
      fat.explain_exemption.fit @explain_exemption
      fat.site_historic @site_historic
      fat.explain_historic_designation.fit @explain_historic_designation
      fat.international_activities @international_activities
      fat.identify_countries.fit @identify_countries
      fat.explain_international_activities.fit @explain_international_activities
      fat.other_agencies @other_agencies
      fat.submitted_to_govt_agency.fit @submitted_to_govt_agency
      fat.program.pick @program
      fat.subject_to_review @subject_to_review
      fat.novice_applicants @novice_applicants
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

end