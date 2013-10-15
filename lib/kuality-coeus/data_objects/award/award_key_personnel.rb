class AwardKeyPersonObject

  include Foundry
  include DataFactory
  include Navigation

  attr_accessor :employee_user_name, :non_employee_id, :project_role,
                :key_person_role, :units, :first_name, :last_name, :full_name,
                :lead_unit

  def initialize(browser, opts={})
    @browser=browser
    defaults = {
        project_role: 'Principal Investigator',
        units:        []
    }
    set_options(defaults.merge(opts))
    @full_name="#{@first_name} #{@last_name}"
  end

  # Navigation done by parent object...
  # TODO: This will need to support Non-employees at some point.
  def create
    add_employee_name
    on AwardContacts do |create|
      # This conditional exists to deal with the fact that
      # a Principal Investigator can also be called a "PI/Contact",
      # in cases where it's an NIH proposal.
      if create.kp_project_role.include? @project_role
        create.kp_project_role.select @project_role
      else
        create.kp_project_role.select_value role_value[@project_role]
        @project_role = create.kp_project_role.selected_options[0].text
      end
      fill_out create, :key_person_role
      create.add_key_person
      create.expand_all
      # Now we need to scrape the UI for the Lead Unit...
      @units=create.units(@full_name)
      @units.each do |unit|
        @lead_unit = unit if create.lead_unit_radio(@full_name, unit).set?
      end
    end
  end

  # ===========
  private
  # ===========

  # This method takes care of filling in the employee
  # user name field...
  def add_employee_name
    on(AwardContacts).expand_all
    if @employee_user_name.nil?
      on(AwardContacts).kp_employee_search
      if @last_name.nil?
        on PersonLookup do |look|
          look.search
          look.return_random
        end
        on AwardContacts do |person|
          div_full_name = person.kp_employee_full_name

          @last_name=div_full_name[/\w+$/]
          @first_name=$~.pre_match.strip
          @full_name="#{@first_name} #{@last_name}"
        end
      else
        on PersonLookup do |look|
          look.last_name.set @last_name
          look.search
          look.return_value @full_name
        end
      end
    else
      on(AwardContacts).kp_employee_user_name.set @employee_user_name
    end
  end

  def role_value
    {
        'Principal Investigator' => 'PI',
        'PI/Contact' => 'PI',
        'Co-Investigator' => 'COI',
        'Key Person' => 'KP'
    }
  end

end

class AwardKeyPersonnelCollection < CollectionsFactory

  contains AwardKeyPersonObject

  def principal_investigator
    self.find{ |person| person.project_role=='Principal Investigator' || person.project_role=='PI/Contact' }
  end

end