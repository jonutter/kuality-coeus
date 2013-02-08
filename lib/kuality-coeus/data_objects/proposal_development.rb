class ProposalDevelopmentObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation
  
  attr_accessor :description, :type, :lead_unit, :activity_type, :project_title,
                :sponsor_code, :start_date, :end_date
  
  def initialize(browser, opts={})
    @browser = browser
    defaults = {
      description: random_alphanums,
      type: "New",
      lead_unit: :random,
      activity_type: :random,
      project_title: random_alphanums,
      sponsor_code: "000500",
      start_date: next_week[:date_w_slashes],
      end_date: next_year[:date_w_slashes]
    }
    set_options(defaults.merge(opts))
  end
    
  def create
    visit(Researcher).create_proposal
    on Proposal do |doc|
      doc.description.set @description
      doc.sponsor_code.set @sponsor_code
      @type=doc.proposal_type.pick @type
      @activity_type=doc.activity_type.pick @activity_type
      @lead_unit=doc.lead_unit.pick @lead_unit
      doc.project_title.set @project_title
      doc.project_start_date.set @start_date
      doc.project_end_date.set @end_date
      doc.save
    end
  end
    
  def edit opts={}
    
    set_options(opts)
  end
    
  def view
    
  end
    
  def delete
    
  end
  
end
    
      