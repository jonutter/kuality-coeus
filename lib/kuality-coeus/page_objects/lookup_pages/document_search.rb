class DocumentSearch < Lookups

  page_url "#{$base_url}portal.do?channelTitle=Document%20Search&channelUrl=#{$base_url+':/'+$context}kew/DocumentSearch.do?"

  element(:document_id) { |b| b.frm.text_field(id: 'documentId') }
  element(:date_created_from) { |b| b.frm.text_field(name: 'rangeLowerBoundKeyPrefix_dateCreated') }

  action(:open_doc) { |document_id, b| b.frm.link(text: document_id).click; b.use_new_tab }
  action(:doc_status) { |document_id, b| b.results_table.row(text: /#{document_id}/)[3].text }

end