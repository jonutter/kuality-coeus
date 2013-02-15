class ProposalDevelopmentObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation
  
  attr_accessor :description, :type, :lead_unit, :activity_type, :project_title,
                :sponsor_code, :start_date, :end_date, :explanation, :document_id, :status,
                :initiator, :created, :sponsor_deadline_date, :key_personnel,
                :special_review, :budget_versions, :permissions

  def self.add_data_object(object_class, instance_var_symb)
    name_string = "add_" + instance_var_symb.to_s.gsub('@', '')
    define_method name_string do |opts={}|
      merge_settings(opts)
      var = make(eval(object_class), opts)
      var.create
      array = instance_variable_get instance_var_symb
      array << var
      instance_variable_set(instance_var_symb, array)
    end
  end

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
      end_date: next_year[:date_w_slashes],
      sponsor_deadline_date: next_week[:date_w_slashes],
      key_personnel: [],
      special_review: [],
      budget_versions: []
    }
    set_options(defaults.merge(opts))
  end
    
  def create
    visit(Researcher).create_proposal
    on Proposal do |doc|
      @document_id=doc.document_id
      @status=doc.status
      @initiator=doc.initiator
      @created=doc.created
      doc.expand_all
      doc.description.set @description
      doc.sponsor_code.set @sponsor_code
      @type=doc.proposal_type.pick @type
      @activity_type=doc.activity_type.pick @activity_type
      @lead_unit=doc.lead_unit.pick @lead_unit
      doc.project_title.set @project_title
      doc.project_start_date.set @start_date
      doc.project_end_date.set @end_date
      doc.explanation.set @explanation
      doc.sponsor_deadline_date.set @sponsor_deadline_date
      doc.save
    end
  end

  # Note that these lines create methods of the form "add_key_personnel".
  # The method name is based on the name of the class instance
  # variable.
  # It must only be used with:
  # 1) Instance variables that are arrays.
  # 2) Data objects that have a create method.
  # DON'T FORGET: pass the instance variable as a symbol
  # and the class name as a string!
  add_data_object('KeyPersonnelObject', :@key_personnel)
  add_data_object('SpecialReviewObject', :@special_review)
  add_data_object('BudgetVersionsObject', :@budget_versions)

  def assign_permissions opts={}
    merge_settings opts
    @permissions = make PermissionsObject, opts
    @permissions.assign
  end

  def delete
    open_document unless on_document?
    on(Proposal).proposal_actions
    on(ProposalActions).delete_proposal
    on(ConfirmationPage).yes
    # Have to update the data object's status value
    # in a valid way (getting it from the system)
    visit DocumentSearch do |search|
      search.document_id.set @document_id
      search.search
      @status=search.doc_status @document_id
    end
  end

  # =======
  private
  # =======

  def merge_settings(opts)
    defaults = {
        document_id: @document_id
    }
    opts.merge!(defaults)
  end



end