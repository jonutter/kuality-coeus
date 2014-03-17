class RoleAssigneeObject < DataFactory

  include StringFactory

  attr_reader :type_code, :member_identifier, :unit_number, :save_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        type_code:   'Principal',
        unit_number: '000001',
        save_type:   :blanket_approve
    }

    set_options(defaults.merge(opts))
    requires :member_identifier
  end

  def create
    on Role do |page|
      page.description.set random_alphanums
      page.assignee_type_code.select @type_code
      page.assignee_id.set @member_identifier
      page.assignee_unit_number.set @unit_number
      page.add_assignee
      page.send(@save_type)
    end
  end

  # =========
  private
  # =========

end

class RoleAssigneesCollection < CollectionsFactory

  contains RoleAssigneeObject

end