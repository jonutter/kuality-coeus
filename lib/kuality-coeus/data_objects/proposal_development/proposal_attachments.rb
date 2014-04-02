class ProposalAttachmentObject < DataFactory

  include Navigation

  attr_reader :type, :file_name, :status, :description, :document_id, :doc_type

  def initialize(browser, opts={})
    @browser = browser
    set_options opts
    requires :document_id, :type, :file_name
  end

  def create
    view
    on AbstractsAndAttachments do |attach|
      attach.expand_all
      attach.proposal_attachment_type.select @type
      attach.proposal_attachment_description.fit @description
      attach.proposal_attachment_file_name.set($file_folder+@file_name)
      attach.attachment_status.fit @status
      attach.add_proposal_attachment
      raise "Unexpected attachment error" if attach.errors.size > 0
    end
  end

  def view
    open_document
    on(Proposal).abstracts_and_attachments unless on_page?(on(AbstractsAndAttachments).proposal_attachment_type)
  end

  def update_from_parent(id)
    @document_id=id
  end

end

class ProposalAttachmentsCollection < CollectionsFactory

  contains ProposalAttachmentObject

end