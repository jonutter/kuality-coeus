class AwardKeyPersonObject

  include Foundry
  include DataFactory
  include Navigation

  attr_accessor :employee_user_name, :non_employee_id, :project_role,
                :key_person_role

  def initialize(browser, opts={})
    @browser=browser
    defaults = {

    }
    set_options(defaults.merge(opts))
  end

end

class AwardKeyPersonnelCollection < CollectionsFactory

  contains AwardKeyPersonObject

end