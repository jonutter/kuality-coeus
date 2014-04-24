class GroupObject < DataFactory

  include StringFactory
  include Navigation

  attr_reader :id, :namespace, :name, :type,
                :principal_name, :assignees, :save_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type:       'Default',
      namespace:  'KC-UNT - Kuali Coeus - Department',
      name:       random_alphanums_plus,
      assignees:  collection('GrAssignees'),
      save_type: :blanket_approve
    }

    set_options(defaults.merge(opts))
  end

  def create
    visit(SystemAdmin).group
    on(GroupLookup).create_new
    on Group do |page|
      page.description.set random_alphanums
      @id=page.id
      fill_out page, :namespace, :name
      page.send(@save_type)
    end
  end

  def add_assignee(opts={})
    view
    @assignees.add opts
  end

  def view
    visit(SystemAdmin).group
    on GroupLookup do |page|
      page.group_id.set @id
      page.search
      page.edit_item @name
    end
  end

end