class GroupAssigneeObject < DataFactory

  include StringFactory
  include Navigation

  attr_reader :type_code, :member_identifier, :save_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type_code: 'Principal',
      save_type: :blanket_approve
    }

    set_options(defaults.merge(opts))
    requires :member_identifier
  end

  def create
    on Group do |page|
      page.description.set random_alphanums
      fill_out page, :type_code, :member_identifier
      page.add_member
      page.send(@save_type)
    end
  end

end

class GrAssigneesCollection < CollectionsFactory

  contains GroupAssigneeObject

end