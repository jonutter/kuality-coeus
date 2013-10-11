class IPUnrecoveredFAObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation

  attr_accessor :fiscal_year, :rate_type, :applicable_rate,
                :on_campus_contract, :source_account, :amount

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        fiscal_year:        right_now[:year],
        rate_type:          '::random::',
        on_campus_contract: :set,
        source_account:     random_alphanums,
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

end

class IPUnrecoveredFACollection < CollectionsFactory

  contains IPUnrecoveredFAObject

  #TODO: Write code that will update indexes when items change their order in the list.

end