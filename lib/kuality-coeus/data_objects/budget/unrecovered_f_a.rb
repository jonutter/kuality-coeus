class UnrecoveredFAObject < DataObject

  include StringFactory
  include DateFactory

  attr_accessor :fiscal_year, :applicable_rate, :campus, :source_account, :amount,
                # Note: Indexing is zero-based!
                :index

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      fiscal_year: right_now[:year]
    }
    set_options(defaults.merge(opts))
  end

  def create
    view
    on DistributionAndIncome do |page|
      page.expand_all

    end
  end

  def view
    # Note: Currently assumes we're already viewing
    # the budget document!
    on(Parameters).distribution__income
  end

  def edit(opts)
    view
    on DistributionAndIncome do |page|
      page.expand_all
      page.fiscal_year(@index).fit opts[:fiscal_year]
      page.applicable_rate(@index).fit opts[:applicable_rate]
      page.campus(@index).pick! opts[:campus]
      page.fa_source_account(@index).fit opts[:source_account]
      page.fa_amount(@index).fit opts[:amount]
      page.save
    end
    update_options(opts)
  end

end

class UnrecoveredFACollection < CollectionsFactory

  contains UnrecoveredFAObject

  #TODO: Write code that will update indexes when items change their order in the list.

  def total_allocated
    self.collect{ |fa| fa.amount.to_f}.inject(0, :+)
  end

end