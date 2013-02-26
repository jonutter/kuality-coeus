class ProposalDevelopmentObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation
  
  attr_accessor :description, :proposal_type, :lead_unit, :activity_type, :project_title,
                :sponsor_code, :start_date, :end_date, :explanation, :document_id, :status,
                :initiator, :created, :sponsor_deadline_date, :key_personnel,
                :special_review, :budget_versions, :permissions, :s2s_questionnaire,
                :proposal_questions, :compliance_questions

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
      description: random_alphanums,
      proposal_type: 'New',
      lead_unit: :random,
      activity_type: :random,
      project_title: random_alphanums,
      sponsor_code: "000#{rand(8)+1}#{rand(1)}0",
      start_date: next_week[:date_w_slashes],
      end_date: next_year[:date_w_slashes],
      sponsor_deadline_date: next_week[:date_w_slashes],
      key_personnel: KeyPersonnelCollection.new,
      special_review: SpecialReviewCollection.new,
      budget_versions: BudgetVersionsCollection.new
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
      @proposal_type=doc.proposal_type.pick @proposal_type
      @activity_type=doc.activity_type.pick @activity_type
      @lead_unit=doc.lead_unit.pick @lead_unit
      doc.project_title.set @project_title
      doc.project_start_date.set @project_start_date
      doc.project_end_date.set @project_end_date
      doc.explanation.set @explanation
      doc.sponsor_deadline_date.set @sponsor_deadline_date
      doc.save
    end
  end

  def add_key_personnel opts={}
    merge_settings(opts)
    kpo = make KeyPersonnelObject, opts
    kpo.create
    @key_personnel << kpo
  end

  def add_special_review opts={}
    merge_settings(opts)
    sro = make SpecialReviewObject, opts
    sro.create
    @special_review << sro
  end

  def add_budget_versions opts={}
    merge_settings(opts)
    bvo = make BudgetVersionsObject, opts
    bvo.create
    @budget_versions << bvo
  end

  def assign_permissions opts={}
    merge_settings opts
    @permissions = make PermissionsObject, opts
    @permissions.assign
  end

  def answer_s2s_questionnaire opts={}
    merge_settings(opts)
    @s2s_questionnaire = make S2SQuestionnaireObject, opts
    @s2s_questionnaire.create
  end

  def answer_proposal_questions opts={}
    merge_settings(opts)
    @proposal_questions = make ProposalQuestionsObject
    @proposal_questions.create
  end

  def answer_compliance_questions opts={}
    merge_settings(opts)
    @compliance_questions = make ComplianceQuestionsObject
    @compliance_questions.create
  end

  def answer_kuali_university_questions opts={}
    merge_settings(opts)
    @kuali_university_questions = make KualiUniversityQuestionsObject
    @kuali_university_questions.create
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

  def view
    open_document unless on_document?
    on Proposal do |page|
      page.proposal unless page.description.exists? || @status=='CANCELED'
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