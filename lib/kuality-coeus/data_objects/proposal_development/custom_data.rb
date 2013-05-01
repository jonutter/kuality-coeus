class CustomDataObject

  include Foundry
  include DataFactory
  include Navigation
  include Utilities
  include StringFactory

  attr_accessor :document_id, :graduate_student_count, :billing_element

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        graduate_student_count: rand(50).to_s,
        billing_element:        random_alphanums(40)
    }
    set_options(defaults.merge(opts))
    requires :document_id
  end

  def create
    navigate
    on CustomData do |create|
      create.expand_all
      fill_out create, :graduate_student_count, :billing_element
      create.save
    end
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document unless on_document?
    on(Proposal).custom_data unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(CustomData).billing_element.exist?
    rescue
      false
    end
  end

end