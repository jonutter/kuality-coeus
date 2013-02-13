module Navigation

  def on_document?
    begin
      on(DocumentHeader).document_id==@document_id
    rescue
      false
    end
  end

end