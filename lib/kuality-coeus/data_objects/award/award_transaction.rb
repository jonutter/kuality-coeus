class AwardTransactionObject

  include Foundry
  include DataFactory
  include Navigation

  attr_accessor :award_id, :comment, :source_award, :destination_award, :obligated_change,
                :anticipated_change

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      comment: random_string
    }
    requires :award_id
    set_options(defaults.merge(opts))
  end

  def create
    navigate
    on TimeAndMoney do |create|
      create.expand_all
      create.transaction_comment.fit @comment
      fill_out create, :source_award, :destination_award, :obligated_change,
               :anticipated_change
      create.add_transaction
    end
  end

# ========
  private
# ========

  def navigate
    doc_search unless on_award?
    on(Award).time_and_money unless on_tm?
  end

  def on_tm?
    if on(Award).headerinfo_table.exist?
      on(Award).header_award_id==@award_id ? true : false
    else
      false
    end
  end

  def on_tm?
    on(Award).t_m_button.exist? ? false : true
  end

end # AwardTransactionObject

class TransactionCollection < Array

end # TransactionCollection