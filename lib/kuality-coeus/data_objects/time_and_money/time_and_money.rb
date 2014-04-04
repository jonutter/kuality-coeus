class TimeAndMoneyObject < DataFactory

  include StringFactory

  attr_reader :id, :status, :transaction_type_code, :transactions,
              :funds_distribution, :transaction_history, :award_number

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        status: 'SAVED',
        transaction_type_code: 'New',
        transactions: collection('Transactions'),
        funds_distribution: []
    }
    set_options(defaults.merge(opts))
    requires :award_number
  end

  # IMPORTANT NOTE:
  # this create method is unusual because
  # the object is "created" upon opening the page.
  # So really what this method is doing is populating
  # the funds_distribution collection with the default lines
  # found on the page.
  def create

  end

  # TODO: Include some means of updating the transaction type code.

  def add_transaction opts={}
    defaults = {
        destination_award: @award_number
    }
    @transactions.add defaults.merge(opts)
  end

  def add_funds_distribution opts={}

    @funds_distribution.add opts
  end

  def submit
    on TimeAndMoney do |page|
      page.submit
      page.hierarchy_table.wait_until_present
      @status = page.header_status
    end
  end

  # ==========
  private
  # ==========



end