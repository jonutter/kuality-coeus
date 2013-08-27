class GroupObject

  include Foundry
  include DataFactory
  include Navigation

  attr_accessor :id, :namespace, :name, :description, :type,
                :principal_name, :assignees

  def initialize(browser, opts={})
    @browser = browser

  end

  def create

  end

end