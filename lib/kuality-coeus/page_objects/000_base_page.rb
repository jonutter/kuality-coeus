class BasePage < PageFactory

  class << self

    def header_tabs
      link "Unit"
      link "Central Admin"
      link "Maintenance"
    end

    def header_elements
      # Needed?
    end

    def frame_element
      element(:frm) { |b| b.frame(id: "iframeportlet") }
    end

    def global_buttons
      action(:expand_all) { |b| b.frm.image(name: "methodToCall.showAllTabs").click }
      action(:submit) { |b| b.frm.image(class: "globalbuttons", title: "submit").click }
      action(:save) { |b| b.frm.image(class: "globalbuttons", title: "save").click }
      action(:blanket_approve) { |b| b.frm.image(class: "globalbuttons", title: "blanket approve").click }
      action(:close) { |b| b.frm.image(class: "globalbuttons", title: "close").click }
      action(:cancel) { |b| b.frm.image(class: "globalbuttons", title: "cancel").click }
    end
    
  end

end