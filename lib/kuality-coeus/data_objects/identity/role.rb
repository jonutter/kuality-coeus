class RoleObject

  include Foundry
  include DataFactory
  include Navigation
  include StringFactory

  attr_accessor :id, :name, :type, :namespace, :description,
                :permissions

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        description:      random_alphanums,
        type:             'Unit',
        name:             random_alphanums,
        namespace:        'KC-UNT - Kuali Coeus - Department',
        assignees:        RoleAssigneesCollection.new(@browser),
        permissions:      [],
        responsibilities: [],
        # TODO: Add this when needed:
        #delegations:      DelegationCollection.new
    }

    set_options(defaults.merge(opts))
  end

  def create
    visit(SystemAdmin).role
    on(RoleLookup).create
    on KimTypeLookup do |page|
      page.type_name.set @type
      page.search
      page.return_value @type
    end
    on Role do |create|
      @id=create.id
      fill_out create, :namespace, :name, :description
      @permissions.each { |id|
        create.add_permission_id.set id
        create.add_permission
      }
      @responsibilities.each { |id|
        create.add_responsibility_id.set id
        create.add_responsibility
      }
      create.blanket_approve
    end
  end

  def add_permission(id)
    view # TODO: Add conditional navigation code here
    on Role do |page|
      page.add_permission_id.set id
      page.add_permission
      page.blanket_approve
    end
    @permissions << id
  end

  def add_assignee(opts)
    view # TODO: Add conditional navigation code here
    @assignees.add opts
  end

  def view
    exists?
    on(RoleLookup).edit_item @name
  end

  def exists?
    visit(SystemAdmin).role
    on RoleLookup do |look|
      fill_out look, :name, :id
      look.search
      if look.results_table.present?
        # TODO: May need to add code that grabs the id value of the Role.
        return true
      else
        return false
      end
    end
  end

end