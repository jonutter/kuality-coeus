class KualiUniversityQuestionsObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation

  attr_accessor :document_id, :dual_dept_appointment, :dual_dept_review_date, :dual_dept_explanation,
                :on_sabbatical, :sabbatical_review_date, :used_by_small_biz, :small_biz_review_date,
                :understand_deadline, :deadline_review_date

  def initialize(browser, opts={})
    @browser = browser

    # PLEASE NOTE:
    # This is an unusual data object class in that
    # it breaks the typical model for radio button
    # methods and their associated class instance variables
    #
    # In general, it's not workable to set up radio button elements
    # to use "Y" and "N" as the instance variables associated with them.
    #
    # These are set up in this way, however, because of how
    # the HTML elements are being defined.
    defaults = {
      dual_dept_appointment: 'N',
      on_sabbatical:         'N',
      used_by_small_biz:     'N',
      understand_deadline:   'Y'
    }

    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create
    navigate
    on Questions do |kuali|
      kuali.show_kuali_university
      fill_out kuali, :dual_dept_appointment, :dual_dept_review_date,
               :dual_dept_explanation, :on_sabbatical, :sabbatical_review_date,
               :used_by_small_biz, :small_biz_review_date, :understand_deadline,
               :deadline_review_date
      kuali.save
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