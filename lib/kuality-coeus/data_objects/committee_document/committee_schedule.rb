class CommitteeScheduleObject

  include Foundry
  include DataFactory
  include StringFactory

  attr_accessor :document_id

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

class CommitteeScheduleCollection < Array

end