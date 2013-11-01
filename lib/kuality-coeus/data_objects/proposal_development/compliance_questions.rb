class ComplianceQuestionsObject < DataObject

  include DateFactory
  include Navigation

  attr_accessor :document_id, :agree_to_ethical_conduct, :conduct_review_date

  def initialize(browser, opts={})
    @browser = browser
    # PLEASE NOTE:
    # This is an unusual data object class in that
    # it breaks the typical model for radio button
    # methods and their associated class instance variables
    #
    # In general, it's not workable to set up radio button elements
    # to use "Y" and "N" as the instance variables associated with them.
    defaults = {
        agree_to_ethical_conduct: 'Y',
        conduct_review_date:      right_now[:date_w_slashes],
    }
    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create
    navigate
    on Questions do |cq|
      cq.show_compliance_questions
      fill_out cq, :agree_to_ethical_conduct, :conduct_review_date
      cq.save
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