class BasePage < PageFactory

  action(:use_new_tab) { |b| b.windows.first.close; b.windows.last.use }

  class << self

    def document_header_elements
      element(:headerinfo_table) { |b| b.frm.div(class: "headerbox").table(class: "headerinfo") }

      value(:document_id) { |p| p.headerinfo_table[0][1].text }
      alias_method :doc_nbr, :document_id
      value(:status) { |p| p.headerinfo_table[0][3].text }
      value(:initiator) { |p| p.headerinfo_table[1][1].text }
      value(:last_updated) {|p| p.headerinfo_table[1][3].text }
      alias_method :created, :last_updated
      value(:committee_id) { |p| p.headerinfo_table[2][1].text }
      alias_method :sponsor_name, :committee_id
      value(:committee_name) { |p| p.headerinfo_table[2][3].text }
      alias_method :pi, :committee_name
    end

    def global_buttons
      action(:submit) { |b| b.frm.button(class: "globalbuttons", title: "submit").click }
      action(:save) { |b| b.frm.button(class: "globalbuttons", title: "save").click }
      action(:blanket_approve) { |b| b.frm.button(class: "globalbuttons", title: "blanket approve").click }
      action(:close) { |b| b.frm.button(class: "globalbuttons", title: "close").click }
      action(:cancel) { |b| b.frm.button(class: "globalbuttons", title: "cancel").click }
      action(:reload) { |b| b.frm.button(class: "globalbuttons", title: "reload").click }
      action(:delete_selected) { |b| b.frm.button(class: "globalbuttons", name: "methodToCall.deletePerson").click }
    end

    def tab_buttons
      action(:expand_all) { |b| b.frm.button(name: "methodToCall.showAllTabs").click }
    end

    def tiny_buttons
      action(:search) { |b| b.frm.button(title: "search", value: "search").click }
      action(:clear) { |b| b.frm.button(name: "methodToCall.clearValues").click }
      action(:cancel) { |b| b.frm.link(title: "cancel").click }
    end

    def search_results_table
      element(:results_table) { |b| b.frm.table(id: "row") }
    end

    def budget_header_elements
      action(:budget_versions) { |b| b.frm.button(text: "Budget Version").click }
      action(:parameters) { |b| b.frm.button(text: "Parameters").click }
      action(:rates) { |b| b.frm.button(text: "Rates").click }
      action(:summary) { |b| b.frm.button(text: "Summary").click }
      action(:Personnel) { |b| b.frm.button(text: "Personnel").click }
      action(:non_personnel) { |b| b.frm.button(text: "Non-Personnel").click }
      action(:distribution_and_income) { |b| b.frm.button(text: "Distribution & Income").click }
      action(:modular_budget) { |b| b.frm.button(text: "Modular Budget").click }
      action(:budget_actions) { |b| b.frm.button(text: "Budget Actions").click }
    end
  end

end

# Included here because, in a sense, the frame element
# is a part of the "base page"
module Watir
  module Container
    def frm
      if frame(id: "iframeportlet").exist?
        frame(id: "iframeportlet")
      else
        self
      end
    end
  end
end