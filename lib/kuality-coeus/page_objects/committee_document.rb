class CommitteeDocument < BasePage

  global_buttons

  class << self

    def committee_header_elements
      buttons 'Committee', 'Members', 'Schedule'
    end

  end

end