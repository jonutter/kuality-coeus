class ReportTrackingObject < DataObject

  attr_accessor :due_date, :preparer, :status, :activity_date, :overdue

  def initialize(browser, opts={})
    @browser=browser
    defaults = {

    }
    set_options(defaults.merge(opts))
  end

end

class ReportTrackingCollection < CollectionsFactory

  contains ReportTrackingObject

end