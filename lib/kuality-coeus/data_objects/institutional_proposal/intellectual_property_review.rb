class IPReviewObject

  include Foundry
  include DataFactory
  include StringFactory
  include DateFactory
  include Navigation

  attr_accessor :document_id, :activities

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        activities: {number: '1', type_code: '::random::'}
    }
    set_options(defaults.merge(opts))
    requires :document_id
  end

end