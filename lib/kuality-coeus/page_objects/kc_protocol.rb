class KCProtocol < BasePage

  tab_buttons
  global_buttons

  class << self

    def protocol_header_elements
      buttons 'Protocol', 'Personnel', 'Questionnaire', 'Custom Data', 'Special Review',
              'Permissions', 'Notes & Attachments', 'Protocol Actions', 'Medusa'
    end

  end

end