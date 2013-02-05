class CommitteeDocumentObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation
  
  attr_accessor :description, :committee_id, :document_id, :status, :committee_name,
                :home_unit, :min_members_for_quorum, :maximum_protocols,
                :adv_submission_days, :review_type, :last_updated, :updated_user,
                :initiator
  
  def initialize(browser, opts={})
    @browser = browser
    
    defaults = {
      description: random_alphanums,
      committee_id: random_alphanums,
      home_unit: "000001",
      committee_name: random_alphanums,
      min_members_for_quorum: rand(100).to_s,
      maximum_protocols: rand(100).to_s,
      adv_submission_days: rand(365).to_s,
      review_type: "Full"
    }
    set_options(defaults.merge(opts))
  end
    
  def create
    go_to_central_admin
    on(CentralAdmin).add_irb_committee
    on Committee do |comm|
      @document_id=comm.document_id
      @initiator=comm.initiator
      @status=comm.status
      comm.description.set @description
      comm.committee_id.set @committee_id
      comm.committee_name.set @committee_name
      comm.home_unit.set @home_unit
      comm.min_members_for_quorum.set @min_members_for_quorum
      comm.maximum_protocols.set @maximum_protocols
      comm.adv_submission_days
      comm.save
    end
  end
    
  def edit opts={}
    
    set_options(opts)
  end

  def submit
    # TODO: Add conditional navigation here
    # Currently this method assumes you're already
    # on the relevant Committee document page.
    on(Committee).submit
  end

  def view
    
  end
  
end
    
      