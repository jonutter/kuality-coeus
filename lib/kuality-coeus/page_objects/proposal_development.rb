class ProposalDevelopmentDocument < BasePage

  document_header_elements
  tab_buttons
  global_buttons

  class << self

    def proposal_header_elements
      action(:proposal) { |b| b.frm.button(value: 'Proposal').click }
      action(:s2s) { |b| b.frm.button(value: 'S2S').click }
      action(:key_personnel) { |b| b.frm.button(value: 'Key Personnel').click }
      action(:special_review) { |b| b.frm.button(value: 'Special Review').click }
      action(:custom_data) { |b| b.frm.button(value: 'Custom Data').click }
      action(:abstracts_and_attachments) { |b| b.frm.button(value: 'Abstracts and Attachments').click }
      action(:questions) { |b| b.frm.button(value: 'Questions').click }
      action(:budget_versions) { |b| b.frm.button(value: 'Budget Versions').click }
      action(:permissions) { |b| b.frm.button(value: 'Permissions').click }
      action(:proposal_summary) { |b| b.frm.button(value: 'Proposal Summary').click }
      action(:proposal_actions) { |b| b.frm.button(value: 'Proposal Actions').click }
      action(:medusa) { |b| b.frm.button(value: 'Medusa').click }
    end

  end

end