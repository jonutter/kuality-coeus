class GroupObject

  include Foundry
  include DataFactory
  include Navigation
  include StringFactory

  attr_accessor :id, :namespace, :name, :description, :type,
                :principal_name, :assignees

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type:        'Default',
      namespace:   '::random::',
      name:        random_alphanums,
      description: random_alphanums,
      assignees:   AssigneesCollection.new
    }

    set_options(defaults.merge(opts))
  end

  def create

  end

  def add_assignee(opts={})
    assignee = make AssigneeObject, opts
    assignee.create
    @assignees << assignee
  end

  # =========
  private
  # =========



end