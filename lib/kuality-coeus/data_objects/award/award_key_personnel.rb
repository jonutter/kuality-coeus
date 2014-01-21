class AwardKeyPersonObject < DataObject

  include Navigation
  include Personnel

  attr_accessor :employee_user_name, :non_employee_id, :project_role,
                :key_person_role, :units, :first_name, :last_name, :full_name,
                :lead_unit, :type, :responsibility, :financial, :recognition,
                :space

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        type:         'employee',
        project_role: 'Principal Investigator',
        units:        []
    }

    set_options(defaults.merge(opts))
    @full_name="#{@first_name} #{@last_name}"
  end

  # Navigation done by parent object...
  def create
    on(AwardContacts).expand_all
    if @employee_user_name.nil? && @non_employee_id.nil?
      get_person
      # TODO: Need to add code that sets the user name or id
    else
      # TODO: Need to add conditional code for
      # if you have a user id but not a name
    end
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
      set_up_units
      create.save
    end
  end

  def edit opts={}
    # TODO: Add navigation
    on AwardContacts do |update|
      update.expand_all
      # TODO: This will eventually need to be fixed...
      # Note: This is a dangerous short cut, as it may not
      # apply to every field that could be edited with this
      # method...
      opts.each do |field, value|
        update.send(field, @full_name).fit value
      end
      update.save
    end
    update_options(opts)
  end

  # TODO: Some of this method should be moved to the Personnel
  # module at some point, so it can be used by the KeyPersonObject.
  def add_unit(unit_number, lead=false)
    # TODO: Add conditional navigation
    on AwardContacts do |add_unit|
      add_unit.expand_all
      add_unit.add_lead_unit(@full_name) if lead
      add_unit.add_unit_number(@full_name).set unit_number
      add_unit.add_unit(@full_name)
      @units << {number: unit_number, name: add_unit.unit_name(@full_name, unit_number) }
      confirmation 'no'
      add_unit.save
    end
    @lead_unit=unit_number if lead
  end

  def add_lead_unit(unit_number)
    add_unit(unit_number, true)
  end

  def set_lead_unit(unit_number)
    # TODO: Add conditional navigation
    on AwardContacts do |page|
      page.lead_unit_radio(@full_name, unit_number).set
      page.save
    end
  end

  def delete_unit(unit_number)
    # TODO: Add conditional navigation
    on AwardContacts do |delete_unit|
      delete_unit.delete_unit(@full_name, unit_number)
      delete_unit.save
    end
    @units.delete(unit_number)
  end

  # ===========
  private
  # ===========

  def page_class
    AwardContacts
  end

end

class AwardKeyPersonnelCollection < CollectionsFactory

  contains AwardKeyPersonObject

  def principal_investigator
    self.find{ |person| person.project_role=='Principal Investigator' || person.project_role=='PI/Contact' }
  end

  def with_units
    self.find_all { |person| person.units.size > 0 }
  end

end