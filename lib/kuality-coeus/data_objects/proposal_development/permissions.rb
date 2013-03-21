class PermissionsObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :roles, :document_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        # For maximal flexibility in supporting
        # custom roles, the @roles instance variable
        # should be a Hash.
        #
        # It should have the role as its Key, and
        # the user name as its Value.
        #
        # Note that the #assign method will take care
        # of saving any roles that already exist in
        # the system but aren't explicitly passed here.
        #
        roles: { 'Aggregator'=>'admin' }
    }

    set_options(defaults.merge(opts))
    requires :document_id
  end

  def assign
    navigate
    # temp storage container for use with @roles below...
    users=[]
    on Permissions do |add|
      @roles.each do |role, username|
        # We don't need to assign a role/user pair
        # if it is already assigned...
        unless add.assigned_role(username)==role
          add.user_name.set username
          add.role.select role
          add.add
        end
      end
      # Now that things are added, we store things
      # temporarily so that we can properly
      # update the @roles variable with the
      # current settings...
      users = add.user_roles_table.to_a
      add.save
    end
    2.times { users.delete_at(0) }
    roles = {}
    users.each { |row| roles.store(row[5],row[1]) }
    # Doing this as a merge because we want to preserve the
    @roles.merge!(roles)
  end

  def edit opts={}
    navigate
    # ...
    set_options(opts)
  end

  def view

  end

  def delete

  end

  # =======
  private
  # =======

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