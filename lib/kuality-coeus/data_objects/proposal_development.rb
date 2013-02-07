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
      start_date: next_week[:custom].strftime("%m/%d/%Y"),
      end_date: next_year[:custom].strftime("%m/%d/%Y")
    }
    set_options(defaults.merge(opts))
  end
    
  def create
    visit(Researcher).create_proposal

  end
    
  def edit opts={}
    
    set_options(opts)
  end
    
  def view
    
  end
    
  def delete
    
  end
  
end
    
      