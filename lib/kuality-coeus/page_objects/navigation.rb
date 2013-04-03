module Navigation

  def open_document
    visit DocumentSearch do |search|
      search.document_id.set @document_id
      search.search
      search.open_doc @document_id
    end
  end

  def on_document?
    begin
      on(DocumentHeader).document_id==@document_id
    rescue
      false
    end
  end

  # Experimental at this point. Not entirely sure it's really going to be
  # useful.
  def fill_out_form(page, *fields)

    methods={
        'Watir::TextField'=>:fit,
        'Watir::Select'   =>:pick!
    }

    fields.each do |field|
      methid=page.send(field).class.to_s
      if methid=='Watir::Radio'
        page.send(field, instance_variable_get('@'+field.to_s))
      else
        fill page, field, methods[methid]
      end
    end

  end
  alias_method :fill_in_form, :fill_out_form
  alias_method :fill_in_page, :fill_out_form
  alias_method :fill_out, :fill_out_form

  # =======
  private
  # =======

  def fill page, field, meth
    page.send(field).send(meth, instance_variable_get('@'+field.to_s))
  end


end