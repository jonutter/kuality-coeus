class KeyPersonnelObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :first_name, :last_name, :role, :document_id, :key_person_role #TODO: Add support for key_person_role

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
      first_name: "Jeff",
      last_name: "Covey",
      role: "Principal Investigator"
    }
    set_options(defaults.merge(opts))
    requires @document_id
  end

  def create
    navigate
    on(KeyPersonnel).employee_search
    on PersonLookup do |look|
      look.last_name.set @last_name
      look.search
      look.return_value "#{@first_name} #{@last_name}"
    end
    on KeyPersonnel do |person|
      person.proposal_role.pick @role
      person.add_person
      person.save
    end
  end

  def edit opts={}

    set_options(opts)
  end

  def view

  end

  def delete

  end

  private

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

end

class KeyPersonnelCollection < Array

  def names
    self.collect { |person| "#{person.first_name} #{person.last_name}" }
  end

  def roles
    self.collect { |person| person.role }
  end

end