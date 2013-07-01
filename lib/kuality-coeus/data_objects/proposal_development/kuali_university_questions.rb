class KualiUniversityQuestionsObject

  include Foundry
  include DataFactory
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
    open_document @doc_type
    on(Proposal).questions unless on_page?(on(Questions).questions_header)
  end

end