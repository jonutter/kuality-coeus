class TimeAndMoneyObject < DataObject

  include Navigation
  include StringFactory

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

  # No create method is needed because
  # the object is "created" upon opening the page

  # TODO: Include some means of updating the transaction type code.

  def add_transaction opts={}
    defaults = {
        comments: random_alphanums
    }
    trans = defaults.merge(opts)
    on TimeAndMoney do |page|
      if page.edit_button.present?
        # We're on a T&M document in final status
        page.edit
        # So now a new doc gets created, so
        # we need to update the DataObject info
        @id = page.header_document_id
        @status = page.header_status
      end
      page.expand_all
      page.comments.fit trans[:comments]
      page.source_award.pick! trans[:source_award]
      page.destination_award.pick! trans[:destination_award]
      page.obligated_change.fit trans[:obligated_change]
      page.anticipated_change.fit trans[:anticipated_change]
      page.add_transaction
      page.save
      trans[:transaction]=page.last_transaction_id
    end
    @transactions << trans
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