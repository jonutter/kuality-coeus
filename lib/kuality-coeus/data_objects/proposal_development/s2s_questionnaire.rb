class S2SQuestionnaireObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :document_id

  def initialize(browser, opts={})
    @browser = browser
    # PLEASE NOTE:
    # This is a unique data object class in that
    # it breaks the typical model for radio button
    # methods and their associated class instance variables
    #
    defaults = {

    }
    set_options(defaults.merge(opts))
    requires @document_id
  end

  def create
    navigate
    on Questions do |page|
      page.show_s2s_questions

    end
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document unless on_document?
    on(Proposal).questions unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(Questions).questions_header.exist?
    rescue
      false
    end
  end

end