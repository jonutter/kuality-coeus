class CommitteeDocument < BasePage

  global_buttons

  class << self

    def committee_header_elements
      element(:committee) { |b| b.frm.button(value: "Committee") }
      element(:members) { |b| b.frm.button(value: "Members") }
      element(:schedule) { |b| b.frm.button(value: "Schedule") }
    end

  end

end