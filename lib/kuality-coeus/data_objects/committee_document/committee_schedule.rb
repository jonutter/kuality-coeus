class CommitteeScheduleObject < DataFactory

  attr_reader :document_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {

    }

    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create

  end

end # CommitteeScheduleObject

class CommitteeScheduleCollection < CollectionsFactory

  contains CommitteeScheduleObject

end