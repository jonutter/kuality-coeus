module Navigation

  def open_document
    unless on_document?
      visit DocumentSearch do |search|
        search.document_id.set @document_id
        search.search
        search.open_doc @document_id
      end
    end
  end

  def on_document?
    begin
      on(DocumentHeader).document_id==@document_id
    rescue
      false
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
        'Watir::TextField' => lambda{|p, f| p.send(f).fit(ivg f)},
        'Watir::Select'    => lambda{|p, f| p.send(f).pick!(ivg f)},
        'Watir::Radio'     => lambda{|p, f| p.send(f, ivg(f)) unless ivg(f)==nil }
    }
    fields.each do |field|
      # TODO: Someday see if there's a way to fix things so this rescue isn't necessary...
      begin
        key = page.send(field).class.to_s
      rescue NoMethodError
        key = 'Watir::Radio'
      end
      methods[key].call(page, field)
    end
  end
  alias_method :fill_in, :fill_out

  # ==========
  private
  # ==========

  def ivg(symb)
    instance_variable_get('@'+symb.to_s)
  end

end