class ParticipantSupportObject < DataFactory

  include StringFactory

  attr_reader :object_code_name, :quantity, :total_base_cost,
              :start_date, :end_date, :cost_sharing, :budget_category

  attr_accessor :index

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      object_code_name: '::random::',
      quantity:         (rand(100)+1).to_s,
      total_base_cost:  random_dollar_value(100000),
    }
    set_options(defaults.merge(opts))
  end

  def create
    on NonPersonnel do |page|
      page.expand_all
      page.new_participant_object_code.pick! @object_code_name
      page.new_participant_quantity.fit @quantity
      page.new_participant_base_cost.fit @base_cost
      page.add_participant_support
    end
  end

end

class ParticipantSupportCollection < CollectionFactory

  contains ParticipantSupportObject

end