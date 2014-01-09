class GroupAssigneeObject < DataObject

  include StringFactory
  include Navigation

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
    on Group do |page|
      page.description.set random_alphanums
      fill_out page, :type_code, :member_identifier
      page.add_member
      page.blanket_approve
    end
  end

end

class GrAssigneesCollection < CollectionsFactory

  contains GroupAssigneeObject

end