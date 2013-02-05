class BasePage < PageFactory

  class << self

    def header_tabs
      link "Unit"
      link "Central Admin"
      link "Maintenance"
    end

    def document_header_elements
      element(:headerinfo_table) { |b| b.frm.div(class: "headerbox").table(class: "headerinfo") }

      value(:document_id) { |p| p.headerinfo_table[0][1].text }
      value(:status) { |p| p.headerinfo_table[0][3].text }
      value(:initiator) { |p| p.headerinfo_table[1][1].text }
      value(:last_updated) {|p| p.headerinfo_table[1][3].text }
      value(:committee_id) { |p| p.headerinfo_table[2][1].text }
      value(:committee_name) { |p| p.headerinfo_table[2][3].text }
    end

    def frame_element
      element(:frm) { |b| b.frame(id: "iframeportlet") }
    end

    def global_buttons
      action(:expand_all) { |b| b.frm.image(name: "methodToCall.showAllTabs").click } # TODO: Think about moving this into its own element group
      action(:submit) { |b| b.frm.image(class: "globalbuttons", title: "submit").click }
      action(:save) { |b| b.frm.image(class: "globalbuttons", title: "save").click }
      action(:blanket_approve) { |b| b.frm.image(class: "globalbuttons", title: "blanket approve").click }
      action(:close) { |b| b.frm.image(class: "globalbuttons", title: "close").click }
      action(:cancel) { |b| b.frm.image(class: "globalbuttons", title: "cancel").click }
    end
    
  end

end