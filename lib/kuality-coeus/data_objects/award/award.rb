class AwardObject

  include Foundry
  include DataFactory
  include Navigation
  include DateFactory
  include StringFactory

  attr_accessor :description, :transaction_type, :award_id, :funding_proposal, :award_status,
                :award_title, :lead_unit, :activity_type, :award_type, :sponsor_id,
                :project_start_date, :project_end_date, :obligation_start_date,
                :obligation_end_date, :anticipated_amount, :obligated_amount, :document_id,
                :creation_date, :transactions

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description:           random_alphanums,
      transaction_type:      '::random::',
      award_status:          '::random::',
      award_title:           random_alphanums,
      activity_type:         '::random::',
      award_type:            '::random::',
      project_start_date:    right_now[:date_w_slashes],
      project_end_date:      in_a_year[:date_w_slashes],
      sponsor_id:            '::random::',
      lead_unit:             '::random::',
      obligation_start_date: right_now[:date_w_slashes],
      obligation_end_date:   in_a_year[:date_w_slashes],
      anticipated_amount:    '1000000',
      obligated_amount:      '1000000',
      transactions:          collection('Transaction')
    }

    set_options(defaults.merge(opts))
  end

  def create
    @creation_date = right_now[:date_w_slashes]
    visit(CentralAdmin).create_award
    on Award do |create|
      create.expand_all
      fill_out create, :description, :transaction_type, :award_status, :award_title,
               :activity_type, :award_type, :obligated_amount, :anticipated_amount,
               :project_start_date, :project_end_date, :obligation_start_date,
               :obligation_end_date
      set_sponsor_id
      set_lead_unit
      create.save
      @document_id = create.header_document_id
      @award_id = create.header_award_id
    end
    add_funding_proposal if @funding_proposal
  end

  def add_funding_proposal # TODO: Add support for multiple funding proposals and merge types.
    on Award do |page|
      page.expand_all
      page.institutional_proposal_number.set @funding_proposal
      page.add_proposal
    end
  end

  def add_transaction opts={}
    defaults={award_id: @award_id}
    @transactions.add defaults.merge(opts)
  end

  # ========
  private
  # ========

  def set_sponsor_id
    if @sponsor_id=='::random::'
      on(Award).lookup_sponsor
      on SponsorLookup do |look|
        look.sponsor_type_code.pick! '::random::'
        look.search
        look.page_links[rand(look.page_links.length)].click if look.page_links.size > 0
        look.return_random
      end
    else
      on(Award).sponsor_id.fit @sponsor_id
    end
  end

  def set_lead_unit
    lu_edit = on(Award).lead_unit_id.present?
    randomize = @lead_unit=='::random::'
    if lu_edit && randomize
      on(Award).lookup_lead_unit
      on UnitLookup do |lk|
        lk.search
        lk.return_random
      end
    elsif lu_edit && !randomize
      on(Award).lead_unit_id.fit @lead_unit
    else
      @lead_unit=on(Award).lead_unit_ro
    end
  end

  # ==========
  private
  # ==========

  def navigate
    doc_search unless on_award?
    on(TimeAndMoney).return_to_award if on_tm?
  end

  def on_award?
    if on(Award).headerinfo_table.exist?
      on(Award).header_award_id==@award_id
    else
      false
    end
  end

  def on_tm?
    !(on(Award).t_m_button.exist?)
  end

end