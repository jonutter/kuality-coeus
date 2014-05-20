class IRBCommitteeObject < DataFactory

  include StringFactory

  attr_reader :description, :document_id, :committee_id, :name, :home_unit,
              :minimum_members, :maximum_protocols, :review_type, :adv_submission_days

  def initialize(browser, opts ={})
    @browser = browser

    defaults ={
        description:         random_alphanums_plus,
        committee_id:        random_alphanums_plus,
        name:                random_alphanums_plus,
        home_unit:           '000001',
        minimum_members:     rand(9)+1,
        maximum_protocols:   rand(99)+1,
        adv_submission_days: rand(30)+1,

    }

    set_options(defaults.merge(opts))
  end

  def create

  end

end