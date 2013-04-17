class AbstractsAndAttachments < ProposalDevelopmentDocument

  proposal_header_elements
  error_messages

  # Proposal Attachments
  element(:proposal_attachment_type) { |b| b.frm.select(id: 'newNarrative.narrativeTypeCode') }
  element(:attachment_status) { |b| b.frm.select(id: 'newNarrative.moduleStatusCode') }
  element(:proposal_attachment_file_name) { |b| b.frm.file_field(name: 'newNarrative.narrativeFile') }
  element(:contact_name) { |b| b.frm.text_field(id: 'newNarrative.contactName') }
  element(:email_address) { |b| b.frm.text_field(id: 'newNarrative.emailAddress') }
  element(:phone_number) { |b| b.frm.text_field(id: 'newNarrative.phoneNumber') }
  element(:comments) { |b| b.frm.text_field(id: 'newNarrative.comments') }
  element(:proposal_attachment_description) { |b| b.frm.text_field(id: 'newNarrative.moduleTitle') }
  action(:add_proposal_attachment) { |b| b.frm.button(name: 'methodToCall.addProposalAttachment').click }

  action(:edit_status) { |type, p| p.proposal_attachment_div(type).select(name: /moduleStatusCode/) }

  action(:show_proposal_attachment) { |type, b| b.frm.button(alt: /#{type}/).click }
  action(:proposal_attachment_div) { |type, b| b.frm.div(id: /tab-ProposalAttachments..#{type}Incomplete-div/) }

  # Personnel Attachments
  element(:person) { |b| b.frm.select(name: 'newPropPersonBio.proposalPersonNumber') }
  element(:personnel_attachment_type) { |b| b.frm.select(id: 'newPropPersonBio.documentTypeCode') }
  element(:personnel_attachment_description) { |b| b.frm.text_field(id: 'newInstituteAttachment.moduleTitle') }
  element(:personnel_attachment_file_name) { |b| b.frm.file_field(name: 'newPropPersonBio.personnelAttachmentFile') }
  action(:add_personnel_attachment) { |b| b.frm.button(name: 'methodToCall.addPersonnelAttachment.anchorPersonnelAttachments0').click }

  element(:personnel_attachment_table) { |b| b.frm.div(id: 'tab-PersonnelAttachments0-div').table }

  # Internal Attachments
  element(:internal_attachment_type) { |b| b.frm.select(id: 'newInstituteAttachment.institutionalAttachmentTypeCode') }
  element(:internal_attachment_description) { |b| b.frm.text_field(id: 'newInstituteAttachment.moduleTitle') }
  element(:internal_attachment_file_name) { |b| b.frm.file_field(name: 'newInstituteAttachment.narrativeFile') }
  action(:add_internal_attachment) { |b| b.frm.button(name: 'methodToCall.addInstitutionalAttachment.anchorInternalAttachments0').click }

  element(:internal_attachments_table) { |b| b.frm.div(id: 'tab-InternalAttachments1-div').table }

  # Abstracts
  element(:abstract_type) { |b| b.frm.select(id: 'newProposalAbstract.abstractTypeCode') }
  element(:abstract_details) { |b| b.frm.text_field(id: 'newProposalAbstract.abstractDetails') }
  action(:add_abstract) { |b| b.frm.button(name: 'methodToCall.addAbstract.anchorAbstracts').click }

  element(:abstracts_table) { |b| b.frm.table(id: 'abstracts-table') }

  # Notes
  element(:note_topic) { |b| b.frm.text_field(id: 'newNote.noteTopicText') }
  element(:note_text) { |b| b.frm.text_field(id: 'newNote.noteText') }
  action(:add_note) { |b| b.frm.button(name: 'methodToCall.insertBONote').click }
  
  element(:notes_table) { |b| b.frm.table(summary: 'view/add notes') }

end