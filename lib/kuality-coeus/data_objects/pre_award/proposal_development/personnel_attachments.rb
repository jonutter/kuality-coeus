class PersonnelAttachmentObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :person, :type, :file_name, :description, :document_id, :doc_type

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        person:      '::random::',
        type:        '::random::',
        description: random_alphanums(30)
    }
    set_options defaults.merge(opts)
    requires :document_id, :file_name
  end

  def add
    navigate
    on AbstractsAndAttachments do |attach|
      attach.expand_all
      fill_out attach, :person
      attach.personnel_attachment_description.fit @description
      attach.personnel_attachment_type.fit @type
      attach.personnel_attachment_file_name.set($file_folder+@file_name)
      attach.add_personnel_attachment
    end
  end

  private

  def navigate
    open_document @doc_type
    on(Proposal).abstracts_and_attachments unless on_page?(on(AbstractsAndAttachments).proposal_attachment_type)
  end

end

class PersonnelAttachmentsCollection < Array



end