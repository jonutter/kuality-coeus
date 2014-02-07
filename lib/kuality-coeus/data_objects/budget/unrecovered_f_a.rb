class UnrecoveredFAObject < DataObject

  include StringFactory

  attr_accessor :fiscal_year, :applicable_rate, :campus, :source_account, :amount,
                # Note: Indexing is zero-based!
                :index

  def initialize(browser, opts={})
    @browser = browser

    defaults = {

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

    end
    update_options(opts)
  end

end

class UnrecoveredFACollection < CollectionsFactory

  contains UnrecoveredFAObject

  #TODO: Write code that will update indexes when items change their order in the list.

  def total_allocated
    self.collect{ |cs| cs.amount.to_f}.inject(0, :+)
  end

end