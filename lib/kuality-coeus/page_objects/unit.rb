class Unit < BasePage

  frame_element
  header_tabs

  action(:add_proposal_development) { |b| b.frm.link(title: "Proposal Development", index: 0).click }

end