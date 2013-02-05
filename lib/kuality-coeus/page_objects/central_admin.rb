class CentralAdmin < BasePage

  frame_element
  header_tabs

  action(:add_irb_committee) { |b| b.frm.link(title: "Create Committeee", index: 0).click }

end