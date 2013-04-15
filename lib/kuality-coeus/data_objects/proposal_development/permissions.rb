class PermissionsObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :document_id, :aggregators, :budget_creators, :narrative_writers, :viewers

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        budget_creators:   [], # Arrays should contain usernames
        narrative_writers: [],
        viewers:           []
    }

    set_options(defaults.merge(opts))
    requires :document_id, :aggregators
  end

  # It's important to realize that this method assigns
  # users to roles, but does not check who is already
  # assigned. You need to make sure that the values
  # used in the instantiation of the class are
  # an accurate reflection of what exists in the site.
  def assign
    navigate
    on Permissions do |add|
      roles.each do |inst_var, role|
        instance_variable_get(inst_var).each do |username|
          unless add.assigned_role(username).include? role
            add.user_name.set username
            add.role.select role
            add.add
          end
        end
      end
      add.save
    end
  end

  def add_roles(username, *roles)
    # get to the right page...
    navigate
    on Permissions do |page|
      # click the edit role button for the right user...
      page.edit_role username
      # This opens a new window, so we have to use it...
      page.windows.last.use
    end
    on Roles do |page|
      roles.each do |role|
        # Set the appropriate role checkbox...
        page.send(damballa(role)).set
        # Add the username to the correct role
        # instance variable...
        instance_variable_get(roles.invert[role]) << username
      end
      page.save
      # Now we're done with the child window so we close it...
      page.close
      # Attach to the main window again...
      page.windows.first.use
    end
  end

  def delete username
    navigate
    on(Permissions).delete username
    roles.each do |role|
      instance_variable_get(role).delete_if { |name| name==username }
    end
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document
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

  def roles
    {
        :@aggregators=>'Aggregator',
        :@viewers=>'Viewer',
        :@budget_creators=>'Budget Creator',
        :@narrative_writers=>'Narrative Writer'
    }
  end

end