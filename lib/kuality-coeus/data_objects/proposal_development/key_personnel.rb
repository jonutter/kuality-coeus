class KeyPersonnelObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :first_name, :last_name, :role, :document_id, :key_person_role,
                :full_name, :user_name, :home_unit, :units

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
      role: 'Principal Investigator',
      units: []
    }
    set_options(defaults.merge(opts))
    requires @document_id
  end

  def create
    navigate
    on(KeyPersonnel).employee_search
    if @last_name==nil
      on PersonLookup do |look|
        look.search
        look.return_random
      end
      on KeyPersonnel do |person|
        @full_name=person.person_name
        @first_name=@full_name[/^\w+/]
        @last_name=@full_name[/\w+$/]
      end
    else
      on PersonLookup do |look|
        look.last_name.set @last_name
        look.search
        look.return_value "#{@first_name} #{@last_name}"
      end
    end
    on KeyPersonnel do |person|
      person.proposal_role.pick @role
      person.key_person_role.fit @key_person_role
      person.add_person
      person.show_person @full_name
      person.show_person_details @full_name
      @user_name=person.user_name @full_name
      @home_unit=person.home_unit @full_name
      # Add gathering of more attributes here as needed
      person.save
    end
  end

  def edit opts={}

    set_options(opts)
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document unless on_document?
    on(Proposal).key_personnel unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(KeyPersonnel).proposal_role.exist?
    rescue
      false
    end
  end

end # KeyPersonnelObject

class KeyPersonnelCollection < Array

  def names
    self.collect { |person| "#{person.first_name} #{person.last_name}" }
  end

  def roles
    self.collect { |person| person.role }
  end

end # KeyPersonnelCollection