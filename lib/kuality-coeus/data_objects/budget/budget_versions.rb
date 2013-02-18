class BudgetVersionsObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :name, :document_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      name: random_alphanums
    }

    set_options(defaults.merge(opts))
    requires @document_id
  end

  def create
    navigate
    on BudgetVersions do |add|
      add.name.set @name
      add.add
      add.save
    end
  end

  def edit opts={}
    navigate
    set_options(opts)
  end

  def view

  end

  def delete

  end

  private

  # Nav Aids...

  def navigate
    open_document unless on_document?
    on(Proposal).budget_versions unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(BudgetVersions).name.exist?
    rescue
      false
    end
  end

end # BudgetVersionsObject

class BudgetVersionsCollection < Array



end # BudgetVersionsCollection