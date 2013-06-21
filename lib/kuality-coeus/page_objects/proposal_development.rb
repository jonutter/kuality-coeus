class ProposalDevelopmentDocument < BasePage

  document_header_elements
  tab_buttons
  global_buttons
  error_messages

  class << self

    def proposal_header_elements
      buttons 'Proposal', 'S2S', 'Key Personnel', 'Special Review', 'Custom Data',
              'Abstracts and Attachments', 'Questions', 'Budget Versions', 'Permissions',
              'Proposal Summary', 'Proposal Actions', 'Medusa'
    end

  end

end