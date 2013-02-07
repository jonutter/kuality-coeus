class BasePage < PageFactory

  class << self

    def document_header_elements
      element(:headerinfo_table) { |b| b.div(class: "headerbox").table(class: "headerinfo") }

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
      action(:expand_all) { |b| b.image(name: "methodToCall.showAllTabs").click } # TODO: Think about moving this into its own element group
      action(:submit) { |b| b.image(class: "globalbuttons", title: "submit").click }
      action(:save) { |b| b.image(class: "globalbuttons", title: "save").click }
      action(:blanket_approve) { |b| b.image(class: "globalbuttons", title: "blanket approve").click }
      action(:close) { |b| b.image(class: "globalbuttons", title: "close").click }
      action(:cancel) { |b| b.image(class: "globalbuttons", title: "cancel").click }
    end
    
  end

end