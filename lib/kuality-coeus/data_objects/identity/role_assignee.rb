class RoleAssigneeObject

  include Foundry
  include DataFactory
  include Navigation
  include StringFactory

  attr_accessor :type_code, :member_identifier

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        type_code: 'Principal'
    }

    set_options(defaults.merge(opts))
    requires :member_identifier
  end

  def create
    on Role do |page|
      page.description.set random_alphanums
      page.assignee_type_code.select @type_code
      page.assignee_id.set @member_identifier
      page.add_assignee
      page.blanket_approve
    end
  end

  # =========
  private
  # =========

end