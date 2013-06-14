class AwardObject

  include Foundry
  include DataFactory
  include Navigation
  include DateFactory

  attr_accessor :description, :transaction_type, :award_id, :funding_proposals, :award_status,
                :award_title, :lead_unit, :activity_type, :award_type, :sponsor_id,
                :project_start_date, :project_end_date, :obligation_start_date,
                :obligation_end_date, :anticipated_amount, :obligated_amount,


  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description:        random_alphanums,
      transaction_type:   '::random::',
      award_status:       '::random::',
      award_title:        random_alphanums,
      activity_type:      '::random::',
      award_type:         '::random::',
      project_start_date: right_now,
      project_end_date:   in_a_year
    }

    set_options(defaults.merge(opts))
  end

  def create
    visit(CentralAdmin).create_award
    on Award do |create|
      create.expand_all
      fill_out create, :description, :transaction_type, :award_status, :award_title,
               :activity_type, :award_type
      create.project_start_date.fit project_start_date[:date_w_slashes]
      create.project_end_date.fit project_end_date[:date_w_slashes]
      create.save
    end
  end

  private



end