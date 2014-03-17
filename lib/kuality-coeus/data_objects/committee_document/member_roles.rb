class MemberRolesObject < DataFactory

  include StringFactory

  attr_reader :document_id, :name, :role, :start_date, :end_date

  def initialize(browser, opts={})
    @browser = browser

    defaults = {

    }

    set_options(defaults.merge(opts))
    requires :name, :document_id
  end

  def create

  end

end # MemberRolesObject

class MemberRolesCollection < CollectionsFactory

  contains MemberRolesObject

end # MemberRolesCollection