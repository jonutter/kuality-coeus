class Unit < BasePage

  page_url "#{$base_url}selectedTab=portalUnitBody"

  frame_element

  action(:add_proposal_development) { |b| b.frm.link(title: "Proposal Development", index: 0).click }

end