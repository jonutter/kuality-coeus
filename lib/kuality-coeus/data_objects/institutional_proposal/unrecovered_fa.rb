class IPUnrecoveredFAObject < DataFactory

  include StringFactory
  include DateFactory
  include Navigation

  attr_reader :fiscal_year, :rate_type, :applicable_rate,
                :on_campus_contract, :source_account, :amount
  attr_accessor :index

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        fiscal_year:        right_now[:year],
        rate_type:          '::random::',
        on_campus_contract: :set,
        source_account:     random_alphanums_plus,
        amount:             random_dollar_value(1000)
    }
    set_options(defaults.merge(opts))
  end

  def create
    view
    on Distribution do |page|
      page.expand_all
      page.add_unrec_f_a_fiscal_year.set @fiscal_year
      page.add_rate_type.pick! @rate_type
      page.add_fa_applicable_rate.fit @applicable_rate
      page.add_fa_campus_flag.fit @on_campus_contract
      page.add_fa_source_account.set @source_account
      page.add_fa_amount.set @amount
      page.add_unrecovered_f_a
      page.save
    end
  end

  def view
    # Note: Currently assumes we're already viewing
    # the institutional proposal!
    on(InstitutionalProposal).distribution
  end

  def edit(opts)
    view
    on Distribution do |page|
      page.expand_all
      #TODO: Add this code
      page.save
    end
    update_options(opts)
  end

  def update(id)
    @document_id=id
  end

end

class IPUnrecoveredFACollection < CollectionsFactory

  contains IPUnrecoveredFAObject

  def total
    self.collect{ |item| item.amount.to_f }.inject(0, :+).round(2)
  end

  # Used because of https://jira.kuali.org/browse/KRACOEUS-3991
  # When that is fixed then test scenarios using this will fail...
  def rounded_total
    self.collect{ |item| item.amount.to_i }.inject(0, :+).round(2)
  end

  def reindex
    self.each_with_index { |fna, i| fna.index=i }
  end

end