class PermissionsObject

  include Foundry
  include DataFactory
  include Navigation

  attr_accessor :document_id, :aggregators, :budget_creators, :narrative_writers,
                :viewers, :approvers, :delete_proposals

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        budget_creators:   [], # Arrays should contain usernames
        narrative_writers: [],
        viewers:           [],
        delete_proposals:  [],
        approvers:         []
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
      # See the roles method defined below...
      roles.each do |inst_var, role|
        get(inst_var).each do |username|
          unless add.user_row(username).present? && add.assigned_role(username).include?(role)
            add.user_name.set username
            add.role.select role
            add.add
            add.user_row(username).wait_until_present
          end
        end
      end
      add.save
      # TODO: Add some logic here to use in case the user is already added to the list (so use add_roles)
    end
  end

  # This method is used when the user is already assigned a
  # role and you need to assign them more roles.
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
        page.send(snakify(role)).set
        # Add the username to the correct role
        # instance variable...
        get(roles.invert[role]) << username
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
      get(role).delete_if { |name| name==username }
    end
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document @doc_type
    on(Proposal).permissions unless on_page?(on(Permissions).user_name)
  end

  # Add/Remove roles here, as needed...
  def roles
    {
        :@aggregators=>'Aggregator',
        :@viewers=>'Viewer',
        :@budget_creators=>'Budget Creator',
        :@narrative_writers=>'Narrative Writer',
        :@approvers=>'approver',
        :@delete_proposals=>'Delete Proposal'
    }
  end

end