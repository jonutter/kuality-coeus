class TimeAndMoneyObject < DataFactory

  include StringFactory

  attr_reader :status, :transaction_type_code, :transactions,
              :funds_distribution, :transaction_history, :award_number,
              :document_id, :versions

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        status:                'SAVED',
        transaction_type_code: 'New',
        transactions:          collection('Transactions'),
        funds_distribution:    collection('FundsDistribution'),
        versions:              []
    }
    set_options(defaults.merge(opts))
    requires :award_number
  end

  # IMPORTANT NOTE:
  # this create method is unusual because
  # the object is "created" upon opening the page.
  # So really what this method is doing is populating
  # the funds_distribution collection with any default lines
  # found on the page.
  def create
    on TimeAndMoney do |page|
      page.expand_all
      @document_id ||= page.header_document_id
      1.upto(page.existing_funds_rows.size) do |x|
        number=x.to_s
        item = make FundsDistributionObject,
                    start_date: page.edit_funds_dist_start_date(number).value,
                    end_date: page.edit_funds_dist_end_date(number).value,
                    direct_cost: page.edit_funds_dist_direct_cost(number).value,
                    fa_cost: page.edit_funds_dist_fa_cost(number).value,
                    number: number
        @funds_distribution << item
      end
    end
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

  def cancel
    on(TimeAndMoney).cancel
    on(Confirmation).yes
    # Hard-coded because the status never
    # actually apppears in the UI during this
    # process.
    @status='CANCELED'
  end

  def check_status
    on TimeAndMoney do |page|
      unless @document_id==page.header_document_id
        @versions << @document_id
        @document_id = page.header_document_id
      end
      @status = page.header_status
    end
  end

  # ==========
  private
  # ==========



end