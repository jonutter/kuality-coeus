class ProposalDevelopmentDocument < BasePage

  header_tabs
  frame_element

  class << self

    def doc_header_elements
      action(:proposal) { |b| b.frm.button(value: "Proposal").click }
      action(:key_personnel) { |b| b.frm.button(value: "Key Personnel").click }
      action(:special_review) { |b| b.frm.button(value: "Special Review").click }
      action(:expand_all) { |b| b.frm.image(name: "methodToCall.showAllTabs").click }
    end

  end

end