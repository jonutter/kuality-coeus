class PermissionsObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :roles, :document_id

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        roles: { 'Aggregator'=>'admin' }
    }

    set_options(defaults.merge(opts))
    requires @document_id
  end

  def assign
    navigate
    on Permissions do |add|
      @roles.each do |role, username|
        unless add.assigned_role(username)==role
          add.user_name.set username
          add.role.select role
          add.add
        end
      end
      users = add.user_roles_table.to_a
      add.save
    end
    2.times { users.delete_at(0) }
    roles = {}
    users.each { |row| roles.store(row[5],row[1]) }
    @roles.merge!(roles)
  end

  def edit opts={}
    navigate
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
    on(Proposal).permissions unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(Permissions).user_name.exist?
    rescue
      false
    end
  end

end