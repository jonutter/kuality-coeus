class CommitteeMemberObject < DataObject

  attr_accessor :document_id, :name, :membership_type, :paid_member, :term_start_date, :term_end_date,
                :roles

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      roles: collection('MemberRoles')
    }

    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create

  end



end # CommitteeMemberObject

class CommitteeMemberCollection < CollectionsFactory

  contains CommitteeMemberObject

end # CommitteeMemberCollection