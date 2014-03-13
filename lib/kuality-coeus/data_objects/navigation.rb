# coding: UTF-8
module Navigation

  include Utilities

  # Determine if right document type...
  # look at the header element...
  #
  # Determine if target document...
  # look at document id
  #
  # Navigate...
  # do not use doc id for navigation
  # update document id after navigation
  #
  # To accomplish the above, the Data Object class
  # must have the following instance variables defined...
  # - @doc_header containing the text of the relevant page title
  # - @document_id containing the "document number" from the header table
  # - @lookup_class containing the lookup page class for the document
  # - @search_key containing a hash with the key being the name of the
  #               search parameter to use, and the value what gets searched
  #
  def open_document
    navigate unless on_document?
  end

  def navigate
    on(BasePage).close_extra_windows
    visit @lookup_class do |page|
      page.send(@search_key.keys[0]).set @search_key.values[0]
      page.search
      # This rescue is a sad necessity, due to
      # Coeus's poor implementation of the Lookup pages
      # in conjunction with user Roles.
      begin
        page.results_table.wait_until_present(5)
      rescue Watir::Wait::TimeoutError
        visit DocumentSearch do |search|
          search.document_id.set @document_id
          search.search
          search.open_doc @document_id
        end
        return
      end
      if @lookup_class==DocumentSearch
        page.open_doc @search_key.values[0]
      else
        page.medusa
      end
    end
    # Must update the document id, now:
    @document_id=on(DocumentHeader).document_id
  end

  def on_document?
    begin
      on(DocumentHeader).document_id==@document_id && @browser.frm.div(id: 'headerarea').h1.text.strip==@doc_header
    rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError, WatirNokogiri::Exception::UnknownObjectException
      false
    end
  end

  def on_page? element
    begin
      element.exist?
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      false
    end
  end

  # Use this if the confirmation dialog may appear.
  # For example: due to missing rates...
  def confirmation(answer='yes')
    begin
      on(Confirmation) do |conf|
        conf.send(answer) if conf.yes_button.present?
      end
    rescue
      # do nothing because the dialog isn't there
    end
  end

  private

  # This overrides the method in the TestFactory.
  # We need this here because of the special way that
  # KC defines radio buttons. See below...
  def parse_fields(opts, name, page, *fields)
    watir_methods=[ lambda{|n, p, f, v| p.send(*[f, n].compact).fit(v) }, # Text & Checkbox
                    lambda{|n, p, f, v| p.send(*[f, n].compact).pick!(v) }, # Select
                    lambda{|n, p, f, v| p.send(*[f, n].compact, v) } # Radio
    ]
    fields.each do |field|
      # This rescue is here because the radio button
      # "element" definitions are *actions* that
      # require a parameter, so just sending the method to the page
      # is not going to work.
      begin
        x = page.send(*[field, name].compact).class.to_s=='Watir::Select' ? 1 : 0
      rescue NoMethodError
        x = 2
      end
      val = opts.nil? ? get(field) : opts[field]
      watir_methods[x].call(name, page, field, val)
    end
  end

end