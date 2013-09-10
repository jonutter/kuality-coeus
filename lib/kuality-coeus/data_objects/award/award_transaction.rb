class AwardTransactionObject

  include Foundry
  include DataFactory
  include Navigation
  include StringFactory

  attr_accessor :award_id, :comment, :source_award, :destination_award, :obligated_change,
                :anticipated_change

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      comment: random_string
    }
    set_options(defaults.merge(opts))
    requires :award_id
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

end # AwardTransactionObject

class TransactionCollection < CollectionsFactory

  contains AwardTransactionObject

end # TransactionCollection