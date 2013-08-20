class BudgetPersonnelObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :type, :name, :job_code, :appointment_type, :base_salary,
                :salary_effective_date, :salary_anniversary_date,
                # TODO: Some day we are going to have to allow for multiple codes and periods, here...
                :object_code_name, :start_date, :end_date, :percent_effort, :percent_charged,
                :period_type, :requested_salary, :calculated_fringe
                #TODO: Add more variables here - "apply inflation", "submit cost sharing", etc.

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        type:        'employee',
        base_salary: random_dollar_value(1000000)
    }

    set_options(defaults.merge(opts))
    requires :name
  end

  def create
    # Navigation is handled by the BudgetVersionsObject method
      if on(Personnel).job_code(@name).present?
        # The person is already listed so do nothing
      else
        on(Personnel).send("#{@type}_search")
        on(page_class(@type))
      end
      set_job_code

  end

  # ========
  private
  # ========

  def set_job_code
    unless @job_code.nil?
      on(Personnel).job_code(@name).set @job_code
    else
      on(Personnel).lookup_job_code(@name)
      on JobCodeLookup do |page|
        page.search
        page.return_random
      end
      @job_code=on(Personnel).job_code.value
    end
  end

  def page_class(type)
    {
        employee:     'PersonLookup',
        non_employee: 'NonOrgAddressBookLookup',
        to_be_named:  'ToBeNamedPersonsLookup'
    }[type.to_sym].constantize
  end

end

class BudgetPersonnelCollection < Array



end