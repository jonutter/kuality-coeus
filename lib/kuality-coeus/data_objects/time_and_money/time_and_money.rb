class TimeAndMoney

  include Foundry
  include DataFactory
  include Navigation

  attr_accessor :id, :status, :transaction_type_code, :transactions,
                :funds_distribution, :transaction_history

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        status: 'SAVED',
        transaction_type_code: 'New',

        # :transactions must contain hashes that look like this:
        # { transaction: '1', # Note this is pulled from the UI
        #   comments: 'comment',
        #   source_award: 'External',
        #   destination_award: '000191-00001',
        #   obligated_change: '99.99',
        #   anticipated_change: '100.00' }
        transactions: [],

        # :funds_distribution must contain hashes that look like this:
        # { number: 1, # This is supplied by the code. It shouldn't have to be passed in.
        #   start_date: '11/01/2013',
        #   end_date: '12/31/2015',
        #   direct_cost: '100.00',
        #   fa_cost:    '999.99' }
        funds_distribution: []
    }
    set_options(defaults.merge(opts))
  end

  def create

  end

  # ==========
  private
  # ==========



end