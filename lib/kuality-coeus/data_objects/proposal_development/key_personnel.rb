class KeyPersonnelObject

  include Foundry
  include DataFactory
  include StringFactory

  attr_accessor :first_name, :last_name, :role, :document_id

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
      first_name: "Jeff",
      last_name: "Covey",
      role: "Principal Investigator"
    }
    set_options(defaults.merge(opts))
    requires @document_id
  end

  def create

  end

  def edit opts={}

    set_options(opts)
  end

  def view

  end

  def delete

  end

  private

  # Nav Aids...

  def navigate
    unless on_document?
      visit DocumentSearch do |search|
        search.document_id.set @document_id
        search.search
        search.open_doc @document_id
      end
      @browser.use(title: "Kuali :: Proposal Development Document")
    end
    unless on_page?
      on(Proposal).key_personnel
    end
  end


  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(KeyPersonnel).proposal_role.exist?
    rescue
      false
    end
  end

  def on_document?
    begin
      on(KeyPersonnel).document_id==@document_id
    rescue
      false
    end
  end

end

