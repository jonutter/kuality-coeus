class ProposalLogObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :number, :log_type, :log_status, :proposal_type, :title,
                :principal_investigator, :lead_unit, :sponsor_id

  def initialize(browser, opts={})
    @browser= browser

    defaults = {
        log_type:               'Permanent',
        proposal_type:          '::random::',
        sponsor_id:             '::random::',
        title:                  random_alphanums,
        lead_unit:              '000001',
    }
    set_options(defaults.merge(opts))
  end

  def create
    visit(CentralAdmin).create_proposal_log
    set_principal_investigator
    on ProposalLog do |create|
      create.expand_all
      @number=create.proposal_number.strip
      @log_status=create.proposal_log_status.strip
      create.description.set random_alphanums
      create.proposal_log_type.pick! @log_type
      fill_out create, :proposal_type, :title, :lead_unit
    end
    set_sponsor_code
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

  def set_sponsor_code
    if @sponsor_id=='::random::'
      on(ProposalLog).find_sponsor_code
      on SponsorLookup do |look|
        look.sponsor_type_code.pick! '::random::'
        look.search
        look.page_links[rand(look.page_links.length)].click if look.page_links.size > 0
        look.return_random
      end
      @sponsor_id=on(ProposalLog).sponsor.value
    else
      on(ProposalLog).sponsor.fit @sponsor_id
    end
  end

end