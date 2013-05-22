module Navigation

  include Utilities

  def open_proposal
    doc_search unless on_proposal?
  end

  def on_proposal?
    begin
      on(DocumentHeader).document_id==@document_id && @browser.title=='Kuali :: Proposal Development Document'
    rescue
      false
    end
  end

  def open_budget
    doc_search unless on_budget?
  end

  def on_budget?
    begin
      on(DocumentHeader).budget_name==@name
    rescue
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

  # Use in the #create method of your data objects for filling out
  # fields. This method eliminates the need to write repetitive
  # lines of code, with one line for every field needing to be
  # filled in.
  #
  # Requirement: The field method name and the class instance variable
  # must be the same!
  #
  # This method currently only supports text fields, selection lists,
  # and radio buttons.
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

end