class ProposalLogObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :number, :log_type, :log_status, :proposal_type, :title,
                :principal_investigator, :lead_unit

  def initialize(browser, opts={})
    @browser= browser

    defaults = {
        log_type:               '::random::',
        proposal_type:          '::random::',
        title:                  random_alphanums,
        lead_unit:              '000001',
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(CentralAdmin).create_proposal_log
    set_principal_investigator
    on ProposalLog do |create|
      @number=create.proposal_number
      @log_status=create.proposal_log_status
      create.description.set random_alphanums
      create.proposal_log_type.pick! @log_type
      fill_out create, :proposal_type, :title, :lead_unit
    end
    on(ProposalLog).blanket_approve
  end

  # =========
  private
  # =========

  def set_principal_investigator
    if @principal_investigator.nil?
      on(ProposalLog).employee_lookup
      on PersonLookup do |look|
        look.search
        look.return_random
      end
      @principal_investigator=on(ProposalLog).principal_investigator_employee.value
    elsif @principal_investigator=~/\d+/
      on(ProposalLog).principal_investigator_non_employee.set @principal_investigator
    else
      on(ProposalLog).principal_investigator_employee.set @principal_investigator
    end
  end


end