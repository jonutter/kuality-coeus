class ProposalDevelopmentDocument < BasePage

  document_header_elements
  tab_buttons
  global_buttons

  class << self

    def proposal_header_elements
      action(:proposal) { |b| b.frm.link(text: "Proposal").click }
      action(:grants_gov) { |b| b.frm.link(text: "Grants.gov").click }
      action(:key_personnel) { |b| b.frm.link(text: "Key Personnel").click }
      action(:special_review) { |b| b.frm.link(text: "Special Review").click }
      action(:custom_data) { |b| b.frm.link(text: "Custom Data").click }
      action(:abstracts_and_attachments) { |b| b.frm.link(text: "Abstracts and Attachments").click }
      action(:questions) { |b| b.frm.link(text: "Questions").click }
      action(:budget_versions) { |b| b.frm.link(text: "Budget Versions").click }
      action(:permissions) { |b| b.frm.link(text: "Permissions").click }
      action(:proposal_summary) { |b| b.frm.link(text: "Proposal Summary").click }
      action(:proposal_actions) { |b| b.frm.link(text: "Proposal Actions").click }
      action(:medusa) { |b| b.frm.link(text: "Medusa").click }
    end

  end

end