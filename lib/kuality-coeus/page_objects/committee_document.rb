class CommitteeDocument < BasePage

  class << self

    def committee_header_elements
      buttons 'Committee', 'Members', 'Schedule'
    end

  end

end