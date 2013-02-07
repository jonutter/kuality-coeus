class ProposalDevelopmentDocument < BasePage

  header_tabs

  class << self

    def proposal_header_elements
      action(:proposal) { |b| b.button(value: "Proposal").click }
      action(:key_personnel) { |b| b.button(value: "Key Personnel").click }
      action(:special_review) { |b| b.button(value: "Special Review").click }

    end

  end

end