class ProposalAttachmentObject

  include Foundry
  include DataFactory
  include Navigation

  attr_accessor :type, :file_name, :status, :document_id, :doc_type

  def initialize(browser, opts={})
    @browser = browser
    set_options opts
    requires :document_id, :type, :file_name
  end

  def add
    navigate
    on AbstractsAndAttachments do |attach|
      attach.expand_all
      attach.proposal_attachment_type.select @type
      attach.proposal_attachment_file_name.set($file_folder+@file_name)
      attach.attachment_status.fit @status
      attach.add_proposal_attachment
    end
  end

  private

  def navigate
    open_document @doc_type
    on(Proposal).abstracts_and_attachments unless on_page?
  end

  def on_page?
    on(AbstractsAndAttachments).proposal_attachment_type.exist?
  end

end

class ProposalAttachmentsCollection < Array



end