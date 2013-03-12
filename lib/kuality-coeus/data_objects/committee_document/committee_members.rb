class CommitteeMemberObject

  include Foundry
  include DataFactory
  include StringFactory

  attr_accessor :document_id, :name, :membership_type, :paid_member, :term_start_date, :term_end_date,
                :roles

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      roles: MemberRolesCollection.new
    }

    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create

  end



end # CommitteeMemberObject

class CommitteeMemberCollection < Array

end # CommitteeMemberCollection