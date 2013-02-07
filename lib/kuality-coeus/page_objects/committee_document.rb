class CommitteeDocument < BasePage

  global_buttons

  class << self

    def committee_header_elements
      element(:committee) { |b| b.button(value: "Committee") }
      element(:members) { |b| b.button(value: "Members") }
      element(:schedule) { |b| b.button(value: "Schedule") }
    end

  end

end