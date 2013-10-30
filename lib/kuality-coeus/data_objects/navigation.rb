module Navigation

  include Utilities

  def open_document doc_header
    doc_search unless on_document?(doc_header)
  end

  def on_document?(doc_header)
    begin
      on(DocumentHeader).document_id==@document_id && @browser.frm.div(id: 'headerarea').h1.text==doc_header
    rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError
      false
    end
  end

  def doc_search
    visit DocumentSearch do |search|
      search.close_parents
      search.document_id.set @document_id
      search.search
      search.open_doc @document_id
    end
  end

  def on_page? element
    begin
      element.exist?
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      false
    end
  end

  def window_cleanup
    on BasePage do |page|
      if page.windows.size > 1 && page.portal_window.exists?
        page.return_to_portal
        page.close_children
      elsif page.windows.size > 1
        page.use_new_tab
        page.close_parents
      end
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

  # Use in the #create method of your data objects for filling out
  # fields. This method eliminates the need to write repetitive
  # lines of code, with one line for every field needing to be
  # filled in.
  #
  # Requirement: The field method name and the class instance variable
  # must be the same!
  #
  def fill_out(page, *fields)
    fill_out_item(nil, page, *fields)
  end
  alias_method :fill_in, :fill_out

  # Same as the above method, but used with methods that take a
  # parameter to identify the target element...
  def fill_out_item(name, page, *fields)
    watir_methods=[ lambda{|n, p, f| p.send(*[f, n].compact).fit(get f) },
                    lambda{|n, p, f| p.send(*[f, n].compact).pick!(get f) },
                    lambda{|n, p, f| p.send(*[f, n].compact, get(f)) }
    ]
    fields.shuffle.each do |field|
      # This rescue is here because the radio button
      # "element" definitions are *actions* that
      # require a parameter, so just sending the method to the page
      # is not going to work.
      begin
        x = page.send(*[field, name].compact).class.to_s=='Watir::Select' ? 1 : 0
      rescue NoMethodError
        x = 3
      end
      watir_methods[x].call(name, page, field)
    end
  end

end