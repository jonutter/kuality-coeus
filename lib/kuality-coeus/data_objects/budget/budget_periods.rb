class BudgetPeriodObject < DataFactory

  include StringFactory
  include Navigation

  attr_reader :start_date, :end_date, :total_sponsor_cost,
              :direct_cost, :f_and_a_cost, :unrecovered_f_and_a,
              :cost_sharing, :cost_limit, :direct_cost_limit, :datified,
              :budget_name, :cost_sharing_distribution_list, :unrecovered_fa_dist_list,
              :participant_support,
              #TODO: Add support for this:
              :number_of_participants
  attr_accessor :number

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      cost_sharing_distribution_list: collection('CostSharing'),
      unrecovered_fa_dist_list:       collection('UnrecoveredFA'),
      participant_support:            collection('ParticipantSupport')
    }

    set_options(defaults.merge(opts))
    requires :start_date, :budget_name, :lookup_class, :doc_header, :search_key
    datify
    add_cost_sharing @cost_sharing
  end

  def create
    open_budget
    on Parameters do |create|
      create.period_start_date.fit @start_date
      create.period_end_date.fit @end_date
      create.total_sponsor_cost.fit @total_sponsor_cost
      fill_out create, :direct_cost, :cost_sharing, :cost_limit, :direct_cost_limit
      create.fa_cost.fit @f_and_a_cost
      create.unrecovered_fa_cost.fit @unrecoverd_f_and_a
      create.add_budget_period
    end
    initialize_unrecovered_fa @unrecovered_f_and_a
  end

  def edit opts={}
    open_budget
    on Parameters do |edit|
      edit.start_date_period(@number).fit opts[:start_date]
      edit.end_date_period(@number).fit opts[:end_date]
      dollar_fields.each do |field|
        confirmation
        edit.send("#{field}_period", @number).fit opts[field]
      end
      edit.save
      break if edit.errors.size > 0
    end
    datify
    add_cost_sharing opts[:cost_sharing]
    initialize_unrecovered_fa opts[:unrecovered_f_and_a]
    set_options(opts)
  end

  def add_item_to_cost_share_dl opts={}
    defaults = {
        amount: random_dollar_value(10000),
        project_period: @number,
        index: @cost_sharing_distribution_list.length
    }
    open_budget
    @cost_sharing_distribution_list.add defaults.merge(opts)
  end

  def add_participant_support opts={}
    open_budget
    on(Parameters).non_personnel
    @participant_support.add opts
  end

  def delete
    open_budget
    on(Parameters).delete_period @number
  end

  def dollar_fields
    [:total_sponsor_cost, :direct_cost, :f_and_a_cost, :unrecovered_f_and_a,
                   :cost_sharing, :cost_limit, :direct_cost_limit]
  end

  # =======
  private
  # =======

  # Nav Aids

  def open_budget
    open_document
    unless on_page?(on(Parameters).on_off_campus) && on_budget?
      on(Proposal).budget_versions
      on(BudgetVersions).open @budget_name
      confirmation
    end
  end

  def on_budget?
    begin
      on(Parameters).budget_name==@budget_name
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      false
    end
  end

  # This takes the period start date and converts it into a Date object
  # which is then stored in @datified.
  #
  # It's important in the context of the Budget Periods Collection,
  # which uses it to determine the order of the Periods on the page.
  def datify
    @datified=Date.parse(@start_date[/(?<=\/)\d+$/] + '/' + @start_date[/^\d+\/\d+/])
  end

  def add_cost_sharing(cost_sharing)
    if @cost_sharing_distribution_list.empty? && !cost_sharing.nil? && cost_sharing.to_f > 0
      cs = make CostSharingObject, project_period: @number,
                amount: cost_sharing, source_account: '',
                index: 0
      @cost_sharing_distribution_list << cs
    end
  end

  def initialize_unrecovered_fa unrec_fa
    if @unrecovered_fa_dist_list.empty? && !unrec_fa.nil? && unrec_fa.to_f > 0
      on(Parameters).distribution__income
      on DistributionAndIncome do |page|
        page.expand_all
        page.existing_fna_rows.each_with_index do |row, index|
          fna_item = make UnrecoveredFAObject, index: index, fiscal_year: row[1].text_field.value,
                          applicable_rate: row[2].text_field.value, campus: row[3].select.selected_options[0].text,
                          source_account: row[4].text_field.value, amount: row[5].text_field.value
          @unrecovered_fa_dist_list << fna_item
        end
      end
    end
  end

end # BudgetPeriodObject

class BudgetPeriodsCollection < CollectionsFactory

  contains BudgetPeriodObject

  def period(number)
    self.find { |period| period.number==number }
  end

  # This will update the number values of the budget periods,
  # based on their start date values.
  def number!
    self.sort_by! { |period| period.datified }
    self.each_with_index { |period, index| period.number=index+1 }
  end

  def total_sponsor_cost
    self.collect{ |period| period.total_sponsor_cost.to_f }.inject(0, :+)
  end

end # BudgetPeriodsCollection