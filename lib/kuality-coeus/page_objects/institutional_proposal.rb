class KCInstitutionalProposal < BasePage

  document_header_elements
  tab_buttons
  global_buttons
  error_messages

  class << self

    def inst_prop_header_elements
      buttons 'Institutional Proposal', 'Contacts', 'Custom Data', 'Special Review',
              'Intellectual Property Review', 'Distribution', 'Medusa',
              'Institutional Proposal Actions'
    end

  end

end