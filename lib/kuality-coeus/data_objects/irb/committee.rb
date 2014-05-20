class IRBCommitteeObject < DataFactory

  include StringFactory
  include Navigation

  attr_reader :description, :document_id, :committee_id, :name, :home_unit,
              :minimum_members, :maximum_protocols, :review_type, :adv_submission_days,
              :members

  def initialize(browser, opts={})
    @browser = browser

    defaults ={
        description:         random_alphanums_plus,
        committee_id:        random_alphanums_plus,
        name:                random_alphanums_plus,
        home_unit:           '000001',
        minimum_members:     rand(9)+1,
        maximum_protocols:   rand(99)+1,
        adv_submission_days: rand(30)+1,
        review_type:         '::random::',
        #members:             collection('Members'),
        save_type:           :save
    }

    set_options(defaults.merge(opts))
  end

  def create
    visit(CentralAdmin).create_irb_committee
    on Committee do |create|
      @document_id = create.document_id
      create.committee_id_field.set @committee_id
      create.committee_name_field.set @name
      fill_out create, :description, :home_unit, :maximum_protocols,
                 :adv_submission_days, :review_type
      create.min_members_for_quorum.set @minimum_members
      create.send(@save_type)
    end
  end

end