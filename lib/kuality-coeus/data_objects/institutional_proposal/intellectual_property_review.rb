class IPReviewObject < DataFactory

  include StringFactory
  include DateFactory
  include Navigation

  attr_reader :document_id, :activities, :submitted_for_review, :reviewer, :save_type

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        reviewer: '::random::',
        submitted_for_review: right_now, # Note: this is the date hash, not the string with slashes
        activities: [{number: '1', type_code: '::random::'}],
        save_type: :save
    }
    set_options(defaults.merge(opts))
    requires :document_id
  end

  # The save type for this method is governed by the @save_type variable,
  # which defaults to :save.
  # You must submit or blanket approve it before it actually does anything useful
  def create
    # TODO: Add helper navigation method(s) here
    on IPReview do |page|
      page.description.set random_alphanums # Note: The description field on this page is required, but seems irrelevant to anything important, at least at the moment
      page.submitted_for_review.set @submitted_for_review[:date_w_slashes]
      @activities.each do |activity|
        page.activity_number.set activity[:number]
        page.ip_review_activity_type_code.pick! activity[:type_code]
        # TODO: Obviously add more here as needed
      end
    end
    set_reviewer
    on(IPReview).send(@save_type)
  end

  def submit
    on(IPReview).submit
  end

  # ==========
  private
  # ==========

  def set_reviewer
    if @reviewer=='::random::'
      on(IPReview).find_reviewer
      on PersonLookup do |search|
        search.search
        search.return_random
      end
      @reviewer=on(IPReview).reviewer.value
    else
      on(IPReview).reviewer.fit @reviewer
    end
  end

  # TODO: Add navigational and other helper methods

end