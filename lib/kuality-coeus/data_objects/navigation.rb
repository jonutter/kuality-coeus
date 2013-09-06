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

  # Use in the #create method of your data objects for filling out
  # fields. This method eliminates the need to write repetitive
  # lines of code, with one line for every field needing to be
  # filled in.
  #
  # Requirement: The field method name and the class instance variable
  # must be the same!
  #
  def fill_out(page, *fields)
    methods={
        'Watir::TextField' => lambda{|p, f| p.send(f).fit(get f)},
        'Watir::Select'    => lambda{|p, f| p.send(f).pick!(get f)},
        'Watir::Radio'     => lambda{|p, f| p.send(f, get(f)) unless get(f)==nil },
        'Watir::CheckBox'  => lambda{|p, f| p.send(f).fit(get f) }
    }
    fields.shuffle.each do |field|
      # TODO: Someday see if there's a way to fix things so this rescue isn't necessary...
      # It's here because the radio button "element" definitions are *actions* that
      # require a parameter, so just sending the method to the page
      # is not going to work.
      begin
        key = page.send(field).class.to_s
      rescue NoMethodError
        key = 'Watir::Radio'
      end
      methods[key].call(page, field)
    end
  end
  alias_method :fill_in, :fill_out

  # Same as the above method, but used with methods that take a
  # parameter to identify the target element...
  def fill_out_item(name, page, *fields)
    methods={
        'Watir::TextField' => lambda{|n, p, f| p.send(f, n).fit(get f)},
        'Watir::Select'    => lambda{|n, p, f| p.send(f, n).pick!(get f)},
        'Watir::Radio'     => lambda{|n, p, f| p.send(f, n, get(f)) unless get(f)==nil },
        'Watir::CheckBox'  => lambda{|n, p, f| p.send(f, n).fit(get f) }
    }
    fields.shuffle.each do |field|
      # TODO: Someday see if there's a way to fix things so this rescue isn't necessary...
      # It's here because the radio button "element" definitions are *actions* that
      # require a parameter, so just sending the method to the page
      # is not going to work.
      begin
        key = page.send(field, name).class.to_s
      rescue NoMethodError
        key = 'Watir::Radio'
      end
      methods[key].call(name, page, field)
    end
  end

end