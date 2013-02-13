class SpecialReviewObject

  include Foundry
  include DataFactory
  include StringFactory

  attr_accessor :type, :approval_status, :document_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type: :random,
      approval_status: :random
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

  #private

  def navigate
    unless on_document?
      visit DocumentSearch do |search|
        search.document_id.set @document_id
        search.search
        search.open_doc @document_id
        search.windows.first.close
        search.windows.last.use
      end
    end
    unless on_page?
      on(Proposal).special_review
    end
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(SpecialReview).type.exist?
    rescue
      false
    end
  end

end

