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

end