class DocumentSearch < BasePage

  page_url "#{$base_url}portal.do?channelTitle=Document%20Search&channelUrl=#{$base_url[/^.+com/]+':'+$base_url[/(?<=com)(\/.+\/)$/]}kew/DocumentSearch.do?"

  tiny_buttons
  search_results_table

  element(:document_id) { |b| b.frm.text_field(id: 'documentId') }

  action(:open_doc) { |document_id, b| b.frm.link(text: document_id).click; b.use_new_tab }
  action(:doc_status) { |document_id, b| b.results_table.row(text: /#{document_id}/)[3].text }

end