class ProposalQuestionsObject < DataObject

  include StringFactory
  include DateFactory
  include Navigation

  attr_accessor :document_id, :agree_to_nih_policy, :policy_review_date

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
      agree_to_nih_policy: 'Y',
      policy_review_date:  right_now[:date_w_slashes]
    }

    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create
    navigate
    on Questions do |pq|
      pq.show_proposal_questions
      fill_out pq, :agree_to_nih_policy, :policy_review_date
      #pq.agree_to_nih_policy @agree_to_nih_policy
      #pq.policy_review_date.set @policy_review_date
      pq.save
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