class BasePage < PageFactory

  class << self

    def header_tabs
      link "Unit"
    end

    def frame_element
      element(:frm) { |b| b.frame(id: "iframeportlet") }
    end

  end

end